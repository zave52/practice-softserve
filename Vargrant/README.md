# Vagrant Multi-VM Environment

This project sets up a multi-VM environment using Vagrant, consisting of a web server, a database server, and a monitoring server.

## Setup

1. **Prerequisites:**
   - [Vagrant](https://www.vagrantup.com/downloads)
   - [Libvirt](https://libvirt.org/)

2. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

3. **Start the environment:**
   ```bash
   vagrant up
   ```

## Accessing the Services

- **Web Server:**
  - The web page is accessible at [http://localhost:8080](http://localhost:8080) in your browser.

- **Database Server:**
  - To query the database from the web server, SSH into the web server:
    ```bash
    vagrant ssh web
    ```
  - The query result is logged in `/var/log/db_query.log`:
    ```bash
    cat /var/log/db_query.log
    ```

- **Monitoring Server:**
  - The Prometheus dashboard is accessible at [http://192.168.56.12:9090](http://192.168.56.12:9090).
  - You can view the status of the web and db servers in the "Targets" section.
