App.Models.Country = Backbone.RelationalModel.extend
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
  collection: 'App.Collections.Country'
  relations: [ {
    type: Backbone.HasMany
    key: 'cities'
    relatedModel: 'App.Models.Cities'
    collectionType: 'App.Collections.Cities'
    reverseRelation:
      key: 'country_id'
      includeInJSON: 'id'
  } ]
  labels:
    id: I18n.t('country.labels.id')
    name: I18n.t('country.labels.name')
    created_at: I18n.t('country.labels.created_at')
    updated_at: I18n.t('country.labels.updated_at')
