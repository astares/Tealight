# Tealight

**Tealight** is a project defining a few extensions to the **[Teapot](https://github.com/zeroflag/Teapot) framework** to make the (tea) time you spend with the [Pharo](http://www.pharo.org) Teapot system even easier. 

Install
---------
You can install **Tealight** by executing the following load scripts:

```Smalltalk
Metacello new 
	repository: 'github://astares/Tealight:main/src';
	baseline: 'Tealight';
	load 	
```	
	
Alternatively you can install **Tealight** also from the [Pharo catalog](http://catalog.pharo.org) using the *Catalog Browser* right from within your Pharo image.

Basic Usage
---------

### Working with the Tealight server
After you have the framework installed you can easily start a **Tealight** web server by selecting

 _"Tealight"_ -> _"WebServer"_ -> _"Start webserver"_

from the Pharo world menu. Internally this starts a Teapot server with some defaults.

![Tealight menu](images/Menu.png)

You can also easily stop the server from the Tealight web server menu by using _"Stop webserver"_ or open a webbrowser on the server by using _"Browse"_.

### Accessing the default Teapot
After you started the server you can easily access the running Teapot instance from your code or playground

```Smalltalk
TLWebserver teapot
```

You can easily experiment with Teapot routes, for instance using

```Smalltalk
TLWebserver teapot 
	GET: '/hi' -> 'HelloWorld'
```

If you point your browser to [http://localhost:8080/hi]() you will receive your first "HelloWorld" greeting.

If you open an inspector on the Teapot instance 

```Smalltalk
TLWebserver teapot inspect
```

you will see that a dynamic route was added:

![Inspector on the teapot](images/InspectorTeapot.png)

So you can dynamically add new routes for GET, POST, DELETE or other HTTP methods interactively.

We recommend to read the [Teapot chapter of the Pharo Enterprise Book](https://ci.inria.fr/pharo-contribution/job/EnterprisePharoBook/lastSuccessfulBuild/artifact/book-result/Teapot/Teapot.html) to get a better understanding of the possibilities of the underlying **Teapot** framework.

Experimenting
---------

### Experimenting with Dynamic Routes

Lets add another dynamic route on our default Teapot, this time a dynamic route with a block as an action.
The block itself receives the request as an argument:

```Smalltalk
TLWebserver teapot 
	GET: '/hello/<user>' -> [:req | 'Hello ', (req at: #user)]
```

You can now use your web browser again to call the newly defined URL. This time you need to give a parameter when you point the webbrowser to the new URL. 

[http://localhost:8080/hello/Pharo](http://localhost:8080/hello/Pharo)  returns **Hello Pharo** while

[http://localhost:8080/hello/Smalltalk](http://localhost:8080/hello/Smalltalk)  returns **Hello Smalltalk** 

### Introduction to Teaspoon

There is a new tool called **Teaspoon** that was added as a custom inspector tool on dynamic routes by Attila Magyar. Attila is the author of Teapot. Let's see how we can access this nice tool.

First inspect our Teapot instance again 

```Smalltalk
TLWebserver teapot inspect
```

but this time click on the dynamic route that we added lately in the displayed list of dynamic routes. The inspector will navigate into another inspector displaying the dynamic route instance. There is a second custom tab extension in this inspector called "Teaspoon":

![Inspector on the teapot](images/Teaspoon.png)

In this inspector tool you see the HTTP method (here **GET**) and the full URL of your dynamic route. You can change the URL by replacing _<user>_ with your name and click on _"Execute Request"_.

This will perform the request and display the result in the inspector again. So you can interactively test your routes right from within your Pharo image without switching to external tools.

The **Teaspoon** tool is especially useful when you experiment with route patterns or if you want to define, implement and test a REST based API with Pharo.

### Cleaning up

If you (by accident) messed up with a single route defintion during your experiments the context menu in the inspector comes to the rescue:


![Remove dynamic routes](images/ContextMenu.png)



to delete a single route or all routes. You can even clean up via script:

```Smalltalk
TLWebserver teapot 
	removeAllDynamicRoutes 
```

For the next part of this tutorial lets remove all defined routes.

Defining a REST based interface
---------

### REST API in annotated methods

While it is nice to experiment with dynamic routes by adding them one by one to the Teapot instance it would be even more convinient 

 * if we could define the REST API using regular Smalltalk methods
 * if we could map each URL easily

To support that ***Tealight*** adds a special utility class (called _TLRESTAPIBuilder_) to help you easily build an API. Lets see how we can use it.

First of all we need to create a simple class in the system either from the browser or with an expression:

```Smalltalk
Object subclass: #ExampleRESTAPI
	instanceVariableNames: ''
	classVariableNames: ''
	package: 'MyApp-REST-API'
```	

Now we can define a class side method:

```Smalltalk
greeting: aRequest
	<REST_API: 'GET' pattern: 'hello'>
	
	^'HelloWorld from Pharo'
```	

As you see we use a pragma in this class marking the class side method as REST API method and defining the kind of HTTP method we support as well as the function path for our little REST service.

### Generate our web API

Now we can use the utility class to generate the dynamic routes for us sending a message to our class ending up in our method:

```Smalltalk
TLRESTAPIBuilder buildAPI 
```	

This creates the dynamic routes for us:


![A dynamic route defined from a method](images/RESTRoute.png)


Also that by default there is an ***"api"*** prefix generated into the URL for all REST based methods so you
need to point your browser to:

  [http://localhost:8080/api/hello]()

If you dislike the default API prefix you can customize this for your own needs:

```Smalltalk
TLRESTApiURLPathBuilder withoutPrefix   "have no API prefix in the URL" 
```	

which would result in [http://localhost:8080/hello]() or 

```Smalltalk
TLRESTApiURLPathBuilder useAPIPrefix: 'mykillerapp/myapi'   "have a custom API prefixin the URL" 
```	

to use a custom prefix for the API location [http://localhost:8080/mykillerapp/myapi/hello]()

Advanced usage
---------

### Versioned REST APIs

There are different architectural styles to define a web based API. As with any regular API you might want to version your API and use a specific part of the URL to depict the version that is used.

If you want to do this you can use another pragma to 

```Smalltalk
callMe: aRequest
	<REST_API: 'GET' versions: #('v1') pattern: 'hello'>
	
	self halt
```	

Now rebuild the whole API quickly by cleaning up and regenerating the dynamic routes again (using the default prefix):	
	
```Smalltalk	
TLRESTApiURLPathBuilder useStandardPrefix. 
TLWebserver teapot removeAllDynamicRoutes.
TLRESTAPIBuilder buildAPI 	
```	

This will now generate a [http://localhost:8080/api/v1/hello]() route - again with a call that ends up in our own method. The **v1** part in the URL shows the user of the API that this is for version 1 of the interface.

### Supporting more than one version

As you may have guessed already you can give more than one version in the pragma. A function that
is supported in two version can be annontated like this:

```Smalltalk	
callAnother: aRequest
	<REST_API: 'GET' versions: #('v1' 'v2') pattern: 'hello'>
	
	^'A method that is supported in both versions'
```

will create two dynamic routes:

 * [http://localhost:8080/api/v1/hello]()
 * [http://localhost:8080/api/v2/hello]()

### Advanced Usage

Over time the API that you provide in your webapp might change from one version of the web interface to another. 

For instance a web method might need to be renamed to fix a typo. This can easily be done now:

```Smalltalk	
callRenamed: aRequest
    <REST_API: 'GET' versions: #('v1') pattern: 'oldName'>
	 <REST_API: 'GET' versions: #('v2') pattern: 'newName'>

    ^'A method that was renamed between two API versions'
```

will create two dynamic routes:

 * [http://localhost:8080/api/v1/oldName]()
 * [http://localhost:8080/api/v2/newName]()

So in version **v1** you still support the old name but the users of your API are encouraged to use the new name in version **v2**.
  
It might also be necessary to move the location of a method in a higher version of your interface - but
you still might want to stay compatible to the old version: 

```Smalltalk	
callMoved: aRequest
    <REST_API: 'GET' versions: #('v1') pattern: 'firstAppearance'>
	 <REST_API: 'GET' versions: #('v2') pattern: 'moved/newAppearance'>

    ^'A method that was moved between two API versions' 
```    

will create two dynamic routes:

 * [http://localhost:8080/api/v1/firstAppearance]()
 * [http://localhost:8080/api/v2/moved/newAppearance]()

So the old route could be used as well as the new one - but still a single Pharo method is called.


### Summary

Tealight makes it easy to experiment with Teapot framework and allows you to easily generate a web based API. While we demonstrated most code here with a HTTP GET all the examples could be done with PUT, DELETE, POST, ... as well.
