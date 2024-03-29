<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Metabase, verified and packaged by Elestio

[Metabase](https://github.com/metabase/metabase) is the easy, open-source way for everyone in your company to ask questions and learn from data.

<img src="https://github.com/elestio-examples/metabase/raw/main/screenshot.png" alt="metabase" width="800">

Deploy a <a target="_blank" href="https://elest.io/open-source/metabase">fully managed metabase</a> on <a target="_blank" href="https://elest.io/">elest.io</a> if you want automated backups, reverse proxy with SSL termination, firewall, automated OS & Software updates, and a team of Linux experts and open source enthusiasts to ensure your services are always safe, and functional.

[![deploy](https://github.com/elestio-examples/metabase/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/metabase)

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/metabase.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Create data folders with correct permissions

    mkdir -p ./files
    chown -R 1000:1000 ./files
    mkdir -p ./data
    chown -R 1000:1000 ./data
    mkdir -p ./plugins
    chown -R 1000:1000 ./plugins

Run the project with the following command

    docker-compose up -d

You can access the Web UI at: `http://your-domain:3003`

## Docker-compose

Here are some example snippets to help you get started creating a container.

    version: "3.3"
    services:
    metabase:
        image: elestio4test/metabase:${SOFTWARE_VERSION_TAG}
        restart: always
        environment:
        - MB_DB_FILE=/metabase-data/metabase.db
        - MB_ANON_TRACKING_ENABLED=false
        - MB_ENABLE_EMBEDDING=true
        - MB_ENABLE_PUBLIC_SHARING=true
        - MB_ENABLE_QUERY_CACHING=true
        - MB_SITE_URL=https://[CI_CD_DOMAIN]
        - MB_EMAIL_FROM_ADDRESS=[DOMAIN]@vm.elestio.app
        - MB_EMAIL_SMTP_HOST=172.17.0.1
        - MB_EMAIL_SMTP_PASSWORD=
        - MB_EMAIL_SMTP_PORT=
        - MB_EMAIL_SMTP_SECURITY=none
        volumes:
        - ./files:/opt/app/files
        - ./data:/metabase-data
        - ./plugins:/plugins
        ports:
        - '172.17.0.1:3003:3000'

# Maintenance

## Logging

The Elestio Metabase Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://github.com/metabase/metabase">Metabase Github repository</a>

- <a target="_blank" href="https://www.metabase.com/docs/latest/">Metabase documentation</a>

- <a target="_blank" href="https://github.com/elestio-examples/metabase">Elestio/metabase Github repository</a>
