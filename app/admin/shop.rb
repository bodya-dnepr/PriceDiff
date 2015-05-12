ActiveAdmin.register Shop do
  permit_params :city_id, :store_chain_id, :lat, :lng, :sub_name

  index do
    selectable_column
    column :store_chain, sortable: 'store_chains.name' do |model|
      name = "#{model.store_chain.name} #{model.sub_name}".squish
      link_to name, admin_store_chain_path(model.store_chain)
    end
    column :country do |model|
      country = model.city.country
      link_to country.name, admin_country_path(country)
    end
    column :city, sortable: 'cities.name'
    column :map do |model|
      if model.location?
        link_to 'Link', "https://maps.google.com/maps?q=#{model.lat},#{model.lng}", target: :_blank
      else
        span class: 'status_tag no' do 'no' end
      end
    end
    column :created_at
    column :updated_at
    actions
  end

  controller do
    def scoped_collection
      super.joins(:store_chain).joins(:city)
    end
  end
end
