 - [Infraestrutura com Terraform](#infraestrutura-com-terraform)
   - [Tecnologias Utilizadas](#tecnologias-utilizadas)
   - [Estrutura do Projeto](#estrutura-do-projeto)
   - [Como Configurar o Terraform](#como-configurar-o-terraform)
     - [Pré-requisitos](#pré-requisitos)
     - [Passos para Executar](#passos-para-executar)
   - [Configurações e Recursos](#configurações-e-recursos)
   - [Como Fazer o Deploy dos Micro Serviços](#como-fazer-o-deploy-dos-micro-serviços)
   - [Autores](#autores)

 ---

 # Infraestrutura com Terraform

 Este repositório contém a configuração do Terraform para provisionar a infraestrutura necessária para o backend do projeto Quickfood na AWS.

 ## Tecnologias Utilizadas

 - **Terraform**: Para gerenciamento de infraestrutura como código.
 - **AWS**: Provedor de nuvem utilizado para hospedar a aplicação.

 ## Estrutura do Projeto

 ```plaintext
 .
 ├── main.tf           # Configuração principal do Terraform
 ├── vars.tf           # Definição de variáveis
 ├── data.tf           # Definição de dados
 ├── eks-cluster.tf    # Configuração do cluster EKS
 ├── eks-node.tf       # Configuração dos nós do EKS
 ├── sg-backend.tf     # Configuração do grupo de segurança para o backend
 ├── iam.tf            # Configuração de políticas e papéis IAM
 ├── eks_vpc.tf        # Configuração do VPC e sub-redes
 └── k8s               # Configurações do Kubernetes
     ├── backoffice
     │   ├── deployment.yaml  # Configuração de deployments do backoffice
     │   ├── service.yaml     # Configuração de serviços do backoffice
     │   └── ingress.yaml     # Configuração de ingressos do backoffice
     ├── pagamento
     │   ├── deployment.yaml  # Configuração de deployments do pagamento
     │   ├── service.yaml     # Configuração de serviços do pagamento
     │   └── ingress.yaml     # Configuração de ingressos do pagamento
     ├── pedido
     │   ├── deployment.yaml  # Configuração de deployments do pedido
     │   ├── service.yaml     # Configuração de serviços do pedido
     │   └── ingress.yaml     # Configuração de ingressos do pedido
     ├── producao
     │   ├── deployment.yaml  # Configuração de deployments da produção
     │   ├── service.yaml     # Configuração de serviços da produção
     │   └── ingress.yaml     # Configuração de ingressos da produção
     └── sqlserver
     │   ├── deployment.yaml  # Configuração de deployments do SQL Server
     │   ├── service.yaml     # Configuração de serviços do SQL Server
     │   └── ingress.yaml     # Configuração de ingressos do SQL Server
     └── namespace.yaml       # Configuração de namespaces
 ```

 ## Como Configurar o Terraform

 ### Pré-requisitos

 - [Terraform](https://www.terraform.io/downloads.html) instalado.
 - [AWS CLI](https://aws.amazon.com/cli/) configurado com suas credenciais.

 ### Passos para Executar

 1. **Clone o repositório:**
    ```bash
    git clone https://github.com/SofArc6Soat/quickfood-terraform-kubernetes.git
    cd quickfood-backend/infra
    ```

 2. **Inicialize o Terraform:**
    ```bash
    terraform init
    ```

 3. **Verifique o que será criado:**
    ```bash
    terraform plan
    ```

 4. **Aplique as configurações:**
    ```bash
    terraform apply
    ```

    Confirme a execução digitando `yes` quando solicitado.

 5. **Destrua a infraestrutura (se necessário):**
    ```bash
    terraform destroy
    ```

 ## Configurações e Recursos

 - **VPC e Sub-redes:** Configurados no arquivo `eks_vpc.tf`.
 - **Cluster EKS:** Configurado no arquivo `eks-cluster.tf`.
 - **Node Group do EKS:** Configurado no arquivo `eks-node.tf`.
 - **Grupos de Segurança:** Configurados no arquivo `sg-backend.tf`.
 - **Papéis e Políticas IAM:** Configurados no arquivo `iam.tf`.
 - **Configurações do Kubernetes:** Configuradas na pasta `k8s`.

 ## Como Fazer o Deploy dos Micro Serviços

 ### Pré-requisitos

 - Cluster EKS configurado e funcionando.
 - Arquivos de configuração do Kubernetes (`deployment.yaml`, `service.yaml`, `ingress.yaml`, `namespace.yaml`) para cada micro serviço e SQL Server.

 ### Passos para Executar o Deploy

 1. **Clone o repositório:**
    ```bash
    git clone https://github.com/SofArc6Soat/quickfood-terraform-kubernetes.git
    cd quickfood-backend/infra
    ```

 2. **Configure as credenciais da AWS:**
    - Certifique-se de que suas credenciais da AWS estão configuradas corretamente.

 3. **Atualize o kubeconfig:**
    - Atualize o kubeconfig para se conectar ao cluster EKS:
      ```bash
      aws eks update-kubeconfig --name <CLUSTER_NAME> --region <REGION>
      ```

 4. **Aplique o Namespace:**
    ```bash
    kubectl apply -f k8s/namespace.yaml
    ```

 5. **Deploy dos Micro Serviços e SQL Server:**
    - **Backoffice:**
      ```bash
      kubectl apply -f k8s/backoffice/deployment.yaml
      kubectl apply -f k8s/backoffice/service.yaml
      kubectl apply -f k8s/backoffice/ingress.yaml
      ```
    - **Pagamento:**
      ```bash
      kubectl apply -f k8s/pagamento/deployment.yaml
      kubectl apply -f k8s/pagamento/service.yaml
      kubectl apply -f k8s/pagamento/ingress.yaml
      ```
    - **Pedido:**
      ```bash
      kubectl apply -f k8s/pedido/deployment.yaml
      kubectl apply -f k8s/pedido/service.yaml
      kubectl apply -f k8s/pedido/ingress.yaml
      ```
    - **Produção:**
      ```bash
      kubectl apply -f k8s/producao/deployment.yaml
      kubectl apply -f k8s/producao/service.yaml
      kubectl apply -f k8s/producao/ingress.yaml
      ```
    - **SQL Server:**
      ```bash
      kubectl apply -f k8s/sqlserver/deployment.yaml
      kubectl apply -f k8s/sqlserver/service.yaml
      kubectl apply -f k8s/sqlserver/ingress.yaml
      ```

 ## Autores

- **Anderson Lopez de Andrade RM: 350452** <br>
- **Henrique Alonso Vicente RM: 354583**<br>