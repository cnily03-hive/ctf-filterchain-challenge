# ctf-filterchain-challenge

This is a CTF challenge taking exploit of the filter chain vulnerability in PHP.

Original text exlporing this vulnerability: *[PHP filter chains: file read from error-based oracle](https://www.synacktiv.com/publications/php-filter-chains-file-read-from-error-based-oracle)*

## Docker

[Dockerfile](Dockerfile) is provided at the root of the project. You can build the image with the following command:

```bash
docker build -t ctf-filterchain:latest .
```

Then run the container with:

```bash
docker run -d -e 'FLAG=flag{example_real_flag}' -p 8000:80 ctf-filterchain:latest
```

Or you can use the [docker-compose.yml](docker-compose.yml) file to run the container with:

```bash
docker-compose up -d
```

Then visit `http://localhost:8000` to see the challenge page.

## Exploitation

Visit `index.php` and try to leak content of `flag.php`, by using [synacktiv/php_filter_chains_oracle_exploit](https://github.com/synacktiv/php_filter_chains_oracle_exploit):

```bash
python3 filters_chain_oracle_exploit.py --target http://host:port/ --verb POST --parameter file --file ./flag.php
```

The first few lines of [flag.php](static/flag.php) tell that passing the specific GET value can show the source code.

The idea to RCE is to write a WebShell file. We can use filter chain again.

```plain
php://filter/read=.../resource=shell.php
```

Firstly, pass `php://filter/resource=shell.php` to generate an empty file.

Then we need filter chain to create something into `shell.php` out of nothing. See original exploit script at [synacktiv/php_filter_chain_generator](https://github.com/synacktiv/php_filter_chain_generator).

But the whole chain is too long (greater than 255). We can split it. For example, for chain `A|B|C` we can split it to 3 requests, passing `A`, `B` and `C` respectively.

The exploit script of this step is provided at [exploit/exploit.py](exploit/exploit.py).

Then visit `shell.php` to execute any system command.

## License

CopyRight (c) Cnily03. All rights reserved.

Licensed under the [MIT](LICENSE) License.
