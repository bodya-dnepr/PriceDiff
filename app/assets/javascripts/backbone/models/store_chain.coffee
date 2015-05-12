App.Models.StoreChain = Backbone.RelationalModel.extend
  fields:
    'id':
      'typification': 'integer'
      'type': 'integer'
    'name':
      'typification': 'string'
      'type': 'text'
    'created_at':
      'typification': 'datetime'
      'type': 'datetime'
    'updated_at':
      'typification': 'datetime'
      'type': 'datetime'
  validation: 'name': 'presence': {}
  collection: 'App.Collections.StoreChain'
  relations: [
    {
      type: Backbone.HasMany
      key: 'shops'
      relatedModel: 'App.Models.Shops'
      collectionType: 'App.Collections.Shops'
      reverseRelation:
        key: 'store_chain_id'
        includeInJSON: 'id'
    }
  ]
  labels:
    id: I18n.t('store_chain.labels.id')
    name: I18n.t('store_chain.labels.name')
    created_at: I18n.t('store_chain.labels.created_at')
    updated_at: I18n.t('store_chain.labels.updated_at')
