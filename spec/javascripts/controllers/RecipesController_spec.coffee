describe "RecipesController", ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null

  # access injected service later
  httpBackend  = null

  setupController = (keywords,results)->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams
      routeParams.keywords = keywords

      # capture the injected service
      httpBackend = $httpBackend

      if results
        request = new RegExp("\/recipes.*keywords=#{keywords}")
        httpBackend.expectGET(request).respond(results)

      ctrl = $controller('RecipesController',
        $scope: scope
        $location: location)
    )

  beforeEach(module("receta"))
  beforeEach(setupController())

  it 'defaults to no recipes', ->
    expect(scope.recipes).toEqualData([])