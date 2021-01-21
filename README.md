# SEFAZ-PB - Ambiente de Desenvolvimento

Este repositório contém o Ambiente de Desenvolvimento para o projeto SEFAZ-PB replicando a infraestrutura de Datalake (Postgres) e GraphQL (Hasura) dos ambientes de homologação e de produção, ambientes estes disponibilizados respectiviamente na infraestrutura do LAViD e na infraestrutura do SEFAZ-PB.

Este ambiente foi desenvolvido considerando toda a documentação disponibilizada no repositório `arialab/sefazpb-ambiente` em https://github.com/arialab/sefazpb-ambiente/edit/master/README.md

## Pré-Requisitos

1) Linux ou macOS.

:warning: Atenção: esta instalação foi testada somente no `Linux` e no `macOS`.

2) `docker` - instalação em https://docs.docker.com/get-docker/

3) `docker-compose` - instalação em https://docs.docker.com/compose/install/

4) `git`, `git lfs`, `wget`, `curl` e `unzip` instalados pela sua distribuição Linux ou macOS (por exemplo, utilizando o `HomeBrew`)

5) Portas `5432` e `8080` disponíveis no host onde será executado o ambiente

6) `<secret-key>` chave simétrica disponibilizada pelo DPO (Data Protection Officer) do projeto SEFAZ-PB

## Instalação do Ambiente

1) Instale o `git lfs`

```console
foo@bar# mkdir lfs && cd lfs && wget https://github.com/git-lfs/git-lfs/releases/download/v2.13.2/git-lfs-linux-amd64-v2.13.2.tar.gz
foo@bar# tar -xzvf git-lfs-linux-amd64-v2.13.2.tar.gz
foo@bar# sudo ./install.sh
foo@bar# git lfs install
```

2) Instale o `docker` (ver https://docs.docker.com/get-docker/) e verifique a instalação. Deve ser possível executar a imagem `hello-world` e ver a saída abaixo:

```console
foor@bar# docker run hello-world

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

3) Clone o repositório por SSH ou HTTPS:

- SSH
```console
foo@bar# git clone git@github.com:arialab/sefazpb-ambiente.git
```

- HTTPS
```console
foo@bar# git clone https://github.com/arialab/sefazpb-ambiente.git
```

Obs.: A senha do GitHub deve ser solicitada duas vezes, sendo a 1a referente a clonagem do repositório e a 2a vez referente ao download do arquivo `data.enc` pelo `git lfs`. Uma saída típica para a clonagem do `sefazpb-ambiente` é:

```console
foo@bar# git clone https://github.com/arialab/sefazpb-ambiente.git

Cloning into 'sefazpb-ambiente'...
Username for 'https://github.com': <USUARIO>       <== 1a solicitação do usuário
Password for 'https://cesdias@github.com': <SENHA> <== 1a solicitação da senha
remote: Enumerating objects: 98, done.
remote: Counting objects: 100% (98/98), done.
remote: Compressing objects: 100% (71/71), done.
remote: Total 314 (delta 63), reused 58 (delta 27), pack-reused 216
Receiving objects: 100% (314/314), 58.87 MiB | 13.27 MiB/s, done.
Resolving deltas: 100% (173/173), done.
Username for 'https://github.com': <USUARIO>       <== 2a solicitação do usuário
Password for 'https://cesdias@github.com': <SENHA> <== 2a solicitação da senha
```

4) Acesse o repositório clonado e verifique se o arquivo`data.enc` foi baixado corretamente. Este arquivo deve ter aproximadamente 97MB e possuir a mesma assinatura abaixo: 

```console
foo@bar# cd sefazpb-ambiente
foo@bar# ls -lah data.enc 
-rw-rw-r-- 1 foo foo 97M jan 21 12:00 data.enc

foo@bar# shasum data.enc
9a73ecb12af0dccfe536b97285aaefa8a03d0489  data.enc
```

Caso o arquivo não tenha essa assinatura ou o tamanho esperado, o `git lfs` pode não estar instalado/inicializado e consequentemente o arquivo `data.enc` correto não foi baixado do GitHub. Reveja a instalação do `git lfs`.

Caso o `git lfs` esteja corretamente instalado, tente baixar manualmente o arquivo `data.enc` pelo `git lfs`:

```console
foo@bar# cd sefazpb-ambiente
foo@bar# git lfs pull data.enc
Username for 'https://github.com': <USUARIO>
Password for 'https://cesdias@github.com': <SENHA>
Downloading LFS objects: 100% (1/1), 102 MB | 19 MB/s
```

Verifique novamente a assinatura:

```console
foo@bar# shasum data.enc
9a73ecb12af0dccfe536b97285aaefa8a03d0489  data.enc
```

5) Prepare o script `setup.sh` para execução.

```console
foo@bar# cd sefazpb-ambiente
foo@bar# chmod a+x setup.sh
```

6) Execute o script de instalação chamado `setup.sh` passando como parâmetro a chave secreta. Ex.:
```console
foo@bar# ./setup.sh 123456789abcdefg
```

Caso a chave secreta não seja especificada, será exibido o modo de uso. Ex.:
```console
foo@bar# ./setup.sh
Usage: ./setup.sh <secret-key>
```

Aguarde a preparação do ambiente e leia as instruções apresentadas ao final da execução do script `setup.sh` para utilizar o ambiente. Em caso de dúvida na execução do `setup.sh`, veja o vídeo no final deste documento.

## Cargas das amostras de dados

1) EFD (utilize as senhas apresentadas no final da execução do script para o usuário postgres e datalakeuser)
```console
foo@bar# psql -h localhost -U postgres -W -f data/app_efd-2020_09_17.sql
```
2) FatoNFE  (utilize as senhas apresentadas no final da execução do script para o usuário postgres e datalakeuser)
```console
foo@bar# psql -h localhost -U postgres -W -f data/app_fatonfe-2020_09_17.sql
```
3) FatoItemNFE  (utilize as senhas apresentadas no final da execução do script para o usuário postgres e datalakeuser)
```console
foo@bar# psql -h localhost -U postgres -W -f app_fatoitemnfe-2020_09_17.sql
```





## Vídeo da Execução do Script de Preparação do Ambiente de Desenvolvimento

[![asciicast](https://asciinema.org/a/P2tRAtVAKe3m64kbMz3TVR2Qp.svg)](https://asciinema.org/a/P2tRAtVAKe3m64kbMz3TVR2Qp)
