ActiveAdmin.register Product do
  permit_params :name, tag_ids: []

  form do |f|
    f.inputs f.object.class do
      f.input :name
      f.input :tags
   end
   f.actions
  end
end
