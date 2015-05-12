App.Models.City = Backbone.RelationalModel.extend(
  fields:
    'id':
      'typification': 'integer'
      'type': 'integer'
    'country_id':
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
  collection: 'App.Collections.City'
  relations: [
    {
      type: Backbone.HasOne
      key: 'country'
      relatedModel: 'App.Models.Country'
      collectionType: 'App.Collections.Country'
    }
    {
      type: Backbone.HasMany
      key: 'shops'
      relatedModel: 'App.Models.Shops'
      collectionType: 'App.Collections.Shops'
      reverseRelation:
        key: 'city_id'
        includeInJSON: 'id'
    }
    {
      type: Backbone.HasMany
      key: 'store_chains'
      relatedModel: 'App.Models.StoreChains'
      collectionType: 'App.Collections.StoreChains'
      reverseRelation:
        key: 'city_id'
        includeInJSON: 'id'
    }
  ]
  labels:
    id: I18n.t('city.labels.id')
    country_id: I18n.t('city.labels.country_id')
    name: I18n.t('city.labels.name')
    created_at: I18n.t('city.labels.created_at')
    updated_at: I18n.t('city.labels.updated_at'))
