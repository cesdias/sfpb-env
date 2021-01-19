# SEFAZ-PB - Ambiente de Desenvolvimento

Este repositório contém o Ambiente de Desenvolvimento para o projeto SEFAZ-PB replicando a infraestrutura de Datalake (Postgres) e GraphQL (Hasura) dos ambientes de homologação e de produção, ambientes estes disponibilizados respectiviamente na infraestrutura do LAViD e na infraestrutura do SEFAZ-PB.

Este ambiente foi desenvolvido considerando toda a documentação disponibilizada no repositório `arialab/sefazpb-ambiente` em https://github.com/arialab/sefazpb-ambiente/edit/master/README.md

## Pré-Requisitos

1) Linux, macOS ou Windows.

Atenção: esta instalação foi testada apenas em Linux e macOS. Para utilizar o Windows, é necessário executar os comandos do script `setup.sh` manualmente.

2) `docker` - instalação em https://docs.docker.com/get-docker/

3) `docker-compose` - instalação em https://docs.docker.com/compose/install/

4) `curl` e `unzip` instalados no Linux ou macOS

5) Portas `5432` e `8080` disponíveis no host onde será executado o ambiente

6) `<secret-key>` chave simétrica disponibilizada pelo DPO (Data Protection Officer) do projeto SEFAZ-PB

## Instalação do Ambiente

1) Abra um Terminal.

2) Clone o repositório por SSH ou HTTPS:

- SSH
```console
foo@bar# git clone git@github.com:arialab/sefazpb-ambiente.git
```

- HTTPS
```console
foo@bar# git clone https://github.com/arialab/sefazpb-ambiente.git
```

3) Acesse o repositório clonado e prepare o script `setup.sh` para execução.
```console
foo@bar# cd sefazpb-ambiente
foo@bar# chmod a+x setup.sh
```

4) Execute o script de instalação chamado `setup.sh` passando como parâmetro a chave secreta. Ex.:
```console
foo@bar# ./setup.sh 123456789abcdefg
```

Caso a chave secreta não seja especificada, será exibido o modo de uso. Ex.:
```console
foo@bar# ./setup.sh
Usage: ./setup.sh <secret-key>
```

Aguarde a preparação do ambiente e as instruções apresentadas ao final da execução do script `setup.sh`.


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
