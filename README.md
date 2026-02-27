# SeniorenAllTagPlus

SeniorenAllTagPlus is a Ruby on Rails application that supports senior citizens in their daily routines with activity planning, wellness guidance, and social features.

## Table of Contents

- [Tech Stack](#tech-stack)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Testing](#testing)
- [Demo](#demo)
- [Deployment (Heroku)](#deployment-heroku)
- [Cloudinary Setup](#cloudinary-setup)
- [Creating a Demo User](#creating-a-demo-user)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Tech Stack

- Ruby 3.1.2
- Rails 7
- PostgreSQL
- Devise authentication
- Bootstrap 5 + SCSS
- Stimulus / Turbo
- Cloudinary + Active Storage

## Features

- Daily activity planner
- Health and wellness tips
- Social interaction tools
- Easy-to-use interface
- Multi-language support

## Prerequisites

Before running the app locally, ensure you have:

- Ruby 3.1.2
- Bundler
- PostgreSQL
- Node.js (for JavaScript runtime tooling used by Rails)

## Demo

You can try out the application here: [Demo Sign In](https://senioren-all-tag-plus-c79d436cda54.herokuapp.com/).

## Installation

To install and set up this project locally, follow these steps:

1. Clone the repository:
    ```sh
    git clone https://github.com/ardidrizi/SeniorenAllTagPlus.git
    ```
2. Navigate to the project directory:
    ```sh
    cd SeniorenAllTagPlus
    ```
3. Install Ruby dependencies:
    ```sh
    bundle install
    ```
4. Set up the database:
    ```sh
    rails db:setup
    ```

## Configuration

Create and configure your environment variables (for example using `.env` in development if you use `dotenv-rails`). Typical values include:

- `MAPBOX_API_KEY`
- `CLOUDINARY_URL` (or configure via Rails credentials)
- Database credentials used by your PostgreSQL setup

## Usage

To start the application, run:

```sh
rails server
```

Then, open your browser and visit `http://localhost:3000`.

## Testing

Run the test suite with:

```sh
bundle exec rspec
```

## Deployment (Heroku)

1. Install the Heroku CLI and make sure you are authenticated (`heroku login`).
2. Create a Heroku app with `heroku create`. Set the Ruby buildpack if needed.
3. Push the latest code: `git push heroku master`.
4. Configure sensitive values:
   - `heroku config:set RAILS_MASTER_KEY=<your-master-key>`
   - `heroku config:set CLOUDINARY_URL=cloudinary://<api_key>:<api_secret>@<cloud_name>`
   - `heroku config:set MAPBOX_API_KEY=<your-mapbox-key>`
   - `heroku config:set SENIORENALLTAGPLUS_DATABASE_PASSWORD=<your-db-password>`
5. Ensure assets precompile by running `heroku run rails assets:precompile` if you hear issues about missing packs.
6. Run migrations: `heroku run rails db:migrate`.
7. Open the live app with `heroku open`.

## Cloudinary Setup

1. Store credentials via `rails credentials:edit` (ensure `config/master.key` is available locally):
   ```yaml
   cloudinary:
     cloud_name: your_cloud_name
     api_key: your_api_key
     api_secret: your_api_secret
   ```
2. Active Storage is configured to use Cloudinary in production (`config/environments/production.rb`).
3. Attachments uploaded in production now use Cloudinary automatically via Active Storage.

## Creating a Demo User

To create a demo user, follow these steps:
1. Navigate to the sign-up page at `http://localhost:3000/users/sign_up`.
2. Fill in the required user details (name, email, password, etc.).
3. Submit the form to create the account.
4. Use the credentials to log in at the [demo link](https://sennioren-all-tag-plus-30bf76768159.herokuapp.com/users/sign_in).

## Contributing

We welcome contributions to improve SeniorenAllTagPlus. To contribute:

1. Fork the repository.
2. Create a new branch:
    ```sh
    git checkout -b feature/YourFeature
    ```
3. Commit your changes:
    ```sh
    git commit -m "Add some feature"
    ```
4. Push to the branch:
    ```sh
    git push origin feature/YourFeature
    ```
5. Open a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Contact

If you have any questions, feel free to open an issue or contact the maintainers at ardianidizi@gmail.com.
