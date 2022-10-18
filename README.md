# Configuração da MV Bitnami - Fatec de Cotia - 2022
A criação desse projeto para ajuda em nossa aula de banco de dados. Esse script foi feito em bash e tem como finalidade configurar uma máquina virtual e expor ela em nossa rede, para isso modificando dois arquivos o pg_**, postgresql.conf e habilitação do firewall.

## Ambiente 
Para isso devemos instalar o seguintes programas:

**VMWare**
> https://www.vmware.com

**VM - Bitnami - Fatec**
> https://fatecspgov-my.sharepoint.com/:u:/g/personal/diogo_barbosa4_fatec_sp_gov_br/EQytHfNn3XNIqygN4V7OCgABO1iatjOFTBfP6RrULbfKZw?e=W0y5ZU

## Recomendações

- Esse script deve ser rodado em um server Bitnami

- Não recomendo executar em ambiente de produção, o script habilita que qualquer máquina tenha acesso ao servidor do banco de dados.

- Pode exec. em uma vm prota. Se houver alguma duvida sobre ip ou se as permições estão de acordo

### Modo de Exec.

- Instalando o Git na maquina.
> sudo apt-get install git

- Clonando o repositorio.
> git clone https://github.com/diogoHenBarbosa/bitnami-config-file

- Indo para o diretorio.
> cd bitnami-config-file

- Dando direito de exec. para o script.
> chmod +x ./init-basic-config.sh

- Exc. o scipt em modo de super Usuario
> ./init-basic-config.sh
