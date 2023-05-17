
# README

<h3 align="left">Languages and Tools:</h3>
<p align="left"> <a href="https://www.docker.com/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/docker/docker-original-wordmark.svg" alt="docker" width="40" height="40"/> </a> <a href="https://www.postgresql.org" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/postgresql/postgresql-original-wordmark.svg" alt="postgresql" width="40" height="40"/> </a> <a href="https://rubyonrails.org" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/rails/rails-original-wordmark.svg" alt="rails" width="40" height="40"/> </a> <a href="https://www.ruby-lang.org/en/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/ruby/ruby-original.svg" alt="ruby" width="40" height="40"/> </a> </p>

## Description

This is a basic account management JSON API, which you can create an account, then deposit, withdraw and get its balance. It is developed with Ruby on Rails, with PostgreSQL database, running on Docker.

## **Setting up**

**Requirements**:

- Docker
- Docker-compose

**Run**:

- First, change the .env.example name to .env
- Then:
```bash
    docker-compose up
    docker-compose run api rake db:create
    docker-compose run api rake db:migrate
    docker-compose run api rake db:migrate RAILS_ENV=test
```

The server will be available on localhost:3000

## Running tests (rspec)
```bash
    docker-compose run api rspec
```

## Documentation:

**Endpoints**:

- *POST /api/v1/accounts*  
    Creates a new account
	- Authentication: Not needed.
	- Body JSON format:
    ```json
    {
        "account": {
            "email": "insert_email"
        }
    }
    ```
 
	- Responses:
		- If e-mail is valid and has been not taken    
			201 status and API Key
		- If e-mail is not valid  
			422 status and error message
		- If e-mail has been taken  
			422 status and error message

**Authenticated endpoints:**  
Add header: *X-Api-Key*, with the account's API Key which was informed on account creation.  
If API Key is not found, all the following endpoints will return:
402 status and error message

- *GET /api/v1/balance*
	- Responses
		200 status and account's current balance

- *POST /api/v1/withdraw*  
    Accepts value with 2 decimals.
	- Body JSON format:
    ```json
    {
        "account_transaction": {
            "value": XXX.XX
        }
    }
    ```

    - Responses
        - If value is valid  
        201 status
        - If value has invalid format  
        422 status and error message
        - If there is not enough balance  
        422 status and error message

- *POST /api/v1/deposit*  
    Accepts value with 2 decimals.
	- Body JSON format:
    ```json
    {
        "account_transaction": {
            "value": XXX.XX
        }
    }
    ```

    - Responses
        - If value is valid  
        201 status
        - If value has invalid format  
        422 status and error message

## Touched files
- Created:
    - /db/migrate files
    - /app/controller files
    - /model files
    - Dockerfile
    - docker-compose.yml
    - /config/database.yml
    - /spec files
    - Gemfile
- Changed:
    - /controllers/application_controller.rb
    - /config/routes.rb
    - /spec/rails_helper.rb
    - /spec/spec_helper.rb