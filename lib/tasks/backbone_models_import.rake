namespace :backbone do
  namespace :import do
    desc "Build put models/validation metadata in app/assets/javascripts/backbone/models"
    task models: :environment do
      Dir[Rails.root.join "app", "models", '**', '*.rb'].each do |file|
        begin
          require file
        rescue
        end
      end

      types = {
        string: 'text',
        integer: 'integer',
        float: 'float',
        email: 'email',
        date: 'date',
        datetime: 'datetime',
        boolean: 'checkbox',
        text: 'textarea'
      }

      relations_types = {
        has_one: "HasOne",
        has_many: "HasMany",
        belongs_to: "HasOne",
        has_and_belongs_to_many: "HasMany"
      }

      (ActiveRecord::Base.descendants - [ActiveAdmin::Comment]).each do |model|
        #1
        schema = {}
        model.columns.collect do |c|
          schema[:"#{c.name}"] = { typification: "#{c.type}", type: types["#{c.type}".to_sym] }
        end

        #2
        validations = validations_for(model)

        #3
        relations = []
        reflections = model.reflect_on_all_associations
        reflections.each do |r|
          relations << { type: "#{relations_types[r.macro]}", model: "#{r.name.to_s.camelize}"}
        end

        scope = OpenStruct.new(schema: schema, validations: validations, model: model, relations: relations)

        erb = ERB.new File.read(File.join(File.dirname(__FILE__), "..", "templates", "erb", "backbone_models_import.js.erb"))

        output = Rails.root.join("app", "assets", "javascripts", "backbone", "models", "#{model.name.underscore}.js")
        File.open(output, 'w+') { |f| f.puts(erb.result(scope.instance_eval { binding })) }
      end
    end

    def validations_for(model)
      validations = {}
      model.validators.each do |validator|
        attribute = validator.attributes.first
        validator_type = validator.class.to_s.gsub(/^Active.*::Validations::/, "").gsub(/Validator$/, "").downcase
        validations[attribute] ||= {}
        validations[attribute][validator_type] = options_from(validator)
      end
      validations
    end

    def options_from(validator)
      options = validator.options.dup
      options.each do |option, value|
        options[option] = value.is_a?(Regexp) ? value.inspect : value
      end
      options
    end

  end
end
