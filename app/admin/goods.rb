ActiveAdmin.register Goods do
  permit_params :name, :product_property_id

  form do |f|
    f.inputs f.object.class do
      f.input :product_property, collection: ProductProperty.all.map {|pp| [pp.full_name, pp.id]  }
      f.input :name
   end
   f.actions
  end
end
