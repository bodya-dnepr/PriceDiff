App.Models.Shop = Backbone.RelationalModel.extend
  fields:
    'id':
      'typification': 'integer'
      'type': 'integer'
    'city_id':
      'typification': 'integer'
      'type': 'integer'
    'store_chain_id':
      'typification': 'integer'
      'type': 'integer'
    'lat':
      'typification': 'decimal'
      'type': 'float'
    'lng':
      'typification': 'decimal'
      'type': 'float'
    'sub_name':
      'typification': 'string'
      'type': 'text'
    'created_at':
      'typification': 'datetime'
      'type': 'datetime'
    'updated_at':
      'typification': 'datetime'
      'type': 'datetime'
  validation: 'city_id': 'presence': {}
  collection: 'App.Collections.Shop'
  relations: [
    {
      type: Backbone.HasOne
      key: 'city'
      relatedModel: 'App.Models.City'
      collectionType: 'App.Collections.City'
    }
    {
      type: Backbone.HasOne
      key: 'store_chain'
      relatedModel: 'App.Models.StoreChain'
      collectionType: 'App.Collections.StoreChain'
    }
  ]
  labels:
    id: I18n.t('shop.labels.id')
    city_id: I18n.t('shop.labels.city_id')
    store_chain_id: I18n.t('shop.labels.store_chain_id')
    lat: I18n.t('shop.labels.lat')
    lng: I18n.t('shop.labels.lng')
    sub_name: I18n.t('shop.labels.sub_name')
    created_at: I18n.t('shop.labels.created_at')
    updated_at: I18n.t('shop.labels.updated_at')
