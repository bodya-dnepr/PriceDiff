ActiveAdmin.register Price do
  permit_params :amount, :goods_id, :shop_id

  form do |f|
    f.inputs f.object.class do
      f.input :goods, collection: Goods.all.map {|g| [g.full_name, g.id]  }
      f.input :shop
      f.input :amount
   end
   f.actions
  end
end
