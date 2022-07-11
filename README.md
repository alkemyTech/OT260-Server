# base-ong-server-ruby
Repositorio base para Caso ONG de Ruby

![image](https://user-images.githubusercontent.com/56528396/154179983-2317c03c-9a74-4c4f-8fc5-b07ef972c470.png)

### Bienvenidos al la Aceleración del grupo **OT260** :rocket:
Durante 6 semanas estaremos trabajando en el desarrollo de una API para una **ONG Somos Más**.


Como tecnologías principales estaremos utilizando **Ruby** y **Ruby on Rails**


## Referencia básica del uso de GIT

A continuación tienen disposición un resumen básico del  **GIT flow** con alguno de los commandos que pueden llegar a utilizar
más habitualmente.

![](https://datasift.github.io/gitflow/GitFlowMasterBranch.png)

* `git clone [nombre-del-repositorio]`: nos permite 'clonar' o traernos una copia de un repositorio en nuestra computadora.

* `git status`: nos permite verificar es 'estado' de cada archivo, ya sea en `working directory` o `staged`.

* `git add [nombre archivo]`: nos permite 'subir' un archivo a la `staging area`

* `git commit -m 'Mensage de commit'`: una vez que todos los archivos que vamos a registrar como modificados estan en la `staging area`, podes usar este comando para registrar una `fotos` del estado de esos archivos.

* `git commit --amend --no-edit`: podemos 'enmendar' un commit si olvidamos agregar algún archivo.

* `git pull`: nos permite traer los últimos cambios del `repositorio remoto` a nuestro `repositorio local`.

* `git checkout [nombre-de-la-rama-de-destino]`: nos permite cambiarnos de `branch`.

* `git checkout -b [nombre-de-la-rama-a-crear]`: nos permite en un único comando crear un branch y cambiarnos a ese branch.

* `git stash`: nos permite almacenar temporalmente los cambios de una rama.

* `git rebase [nombre-de-la-rama-que-contiene-los-ultimos-cambios]`: nos permite actualizar nuestro branch con los últimos cambios. Generalmente vamos a utilizar `git rebase main` para traer los cambios que contenga la branch `main`.

* `git push origin [nombre-de-la-rama]`: nos permite subir los últimos cambios de nuestro `repositorio local` al `repositorio remoto`. Recuerda que ***NUNCA*** hacer `git push origin main` ya que primero debes crear un `pull request` en github para discutir los cambios realizados con el equipo.
Si el `push` es realizado despues de un `rebase`, es habitual agregar el flag `--force-with-lease` para forzar la reescritura del
historial de commits.

## Workflow GIT(Conventional Commits)

A la hora de crear `branches` y `commits` vamos a estar usando la convención de [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/). A continuación les dejo un ejemplo:

* `Nombrar un branch`: si tenemos un ticket de `Jira` que tiene la información

```
    Código del ticket: OT-151-21
    Título del ticket : Crear modelo, migración y controlador base de Members
```

Entonces el branch se podrá llamar `feat/OT-151-21-model-migration-controller-member`, trantando de no exederse mucho de los 50 carateres en la longitud del nombre.

* `Mensaje de commit`: se podrá usar un mensaje descriptivo parecido al nombre del branch como por ejemplo `feat OT-151-21: add model migration and controller for member`

En caso de que el branch sirva para ***reparar*** un error el en código se deberá cambiar `feat` por `fix`

## Comandos básicos Rubocop

Rubocop es un [Lint](https://es.wikipedia.org/wiki/Lint), el cual no ayuda a mejorar la calidad y la prolijidad en la sintaxis
de nuestro código. Podemos ejecutar en nuestra terminal el comando `bundle exec rubocop` para detectar la `offenses` o errores
de sintaxis que no cumple con las convenciones de Ruby, Rails y RSpec.


## Comando básicos para test(RSpec)

Aunque por defecto Ruby on Rails nos ofrece `Minitest` como framework de testing por defecto, vamos a utilizar `Rspec` como
framework de pruebas en este proyecto. A continuación tenemos una lista de los comandos más habituales:

* Comando por defecto para ejecutar TODOS los specs: `bundle exec rspec`

* Comando para ejecutar los specs de un directorio: `bundle exec rspec spec/models`

* Comando para ejecutar specs de un archivo: `bundle exec rspec spec/controllers/accounts_controller_spec.rb`

* Comando para ejecutar un solo example dentro de un archivo:
  `bundle exec rspec spec/controllers/accounts_controller_spec.rb:8`

## Gemas instaladas en el proyecto

Este es listado de gemas agregadas al proyecto, se recomienda explorar cada una para entender que usos le podemos dar en nuestro proyecto.

* [dotenv](https://github.com/bkeepers/dotenv)
* [jsonapi-serializer](https://github.com/jsonapi-serializer/jsonapi-serializer)
* [rspec-rails](https://github.com/rspec/rspec-rails)
* [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)
* [pry-byebug](https://github.com/deivid-rodriguez/pry-byebug)
* [pry-rails](https://github.com/pry/pry-rails)
* [annotate](https://github.com/ctran/annotate_models)
* [brakeman](https://github.com/presidentbeef/brakeman)
* [rails_best_practices](https://github.com/flyerhzm/rails_best_practices)
* [rubocop](https://github.com/rubocop/rubocop)
* [rubocop-performance](https://docs.rubocop.org/rubocop-performance/index.html)
* [rubocop-rails](https://docs.rubocop.org/rubocop-performance/index.html)
* [rubocop-rspec](https://github.com/rubocop/rubocop-rspec)
* [faker](https://github.com/faker-ruby/faker)
* [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
* [simplecov](https://github.com/simplecov-ruby/simplecov)

## Referencias bibliográficas

Algunas referencias bibliográficas que nos pueden ser de utilidad en el desarrollo de nuestra API.

* [Master Ruby Web APIs](https://devblast.com/r/master-ruby-web-apis/toc)
* [Modular Rails](https://devblast.com/r/modular-rails/toc)
* [API on Rails(Free ebook)](https://github.com/madeindjs/api_on_rails)
* [Testing Rails](https://books.thoughtbot.com/assets/testing-rails.pdf)

