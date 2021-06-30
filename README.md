# Teste A/B com a plataforma VWO

Este documento apresenta o processo de instalação, configuração e utilização da plataforma [VWO](vwo.com).

## Sobre

O Teste A/B disponível na plataforma, possibilita a criação de teste A/V com diferentes abordagens que estão descritas na sessão [Teste](#teste)

## Instalação

### Instalação da dependência do VWO

O SDK para iOS é instalado no projeto através de Cocoapods, basta adicionar no Podfile a dependência `pod 'VWO'` e depois executar o comando `pod install`.

### Inicialização do ambiente

No arquivo `AppDelegate.swift`, adicionar na função `application` o código de inicialização do VWO.

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
	
	// VWO inicialization
	VWO.launch(apiKey: "<api-key>", config: nil) {
		print("Test A/B Running...")
	} failure: { errorString in
		print(errorString)
	}
	
	return true
}
```
Conforme apresentando no código acima, é necessário possuir a chave API, para conseguir esta chave, é necessário  cadastrar um app no site https://app.vwo.com/ e seguir para a etapa de [Configuração](#configuração).

## Configuração

A configuração do Teste A/B é necessário a realização de 3 etapas: 1. 

1. [Adicione o aplicativo móvel](#adicione-o-aplicativo-móvel)
2. [Defina as variáveis](#defina-as-variáveis)

### Adicione o aplicativo móvel

Para adicionar um novo aplicativo para teste A / B usando VWO, execute o seguinte procedimento:

1. Acesse https://app.vwo.com/#/dashboard
2. Na barra lateral, vá na sessão **Testing -> Mobile App A/B**
3. Acesse a tab **Apps**
4. Clique em **Create App**
5. Conforme você adiciona um aplicativo, o VWO gera chaves de API para as plataformas iOS e Android. Você pode observar a chave API na seção **Configurações** para usá-la durante a [inicialização do aplicativo](#inicialização-do-ambiente).

### Defina as variáveis

Variáveis ​​de teste são elementos ou parâmetros de seu aplicativo móvel. Depois de definir uma variável, você pode executar um número ilimitado de testes A / B na variável sem qualquer alteração de código ou reimplantação. **Por exemplo,** você pode criar uma variável do tipo string para testar diferentes versões de texto na tela do aplicativo.

1.  Na guia **Aplicativos** , selecione o aplicativo móvel para o qual deseja criar variáveis ​​de teste.
2.  Para adicionar um elemento para teste, na seção Variáveis, clique em **Criar Variável** .
3.  Atribua um nome à variável e selecione seu tipo de dados.
4.  Tipo Valor padrão (valor atual ou valor se não houver teste A / B).
5.  Para adicionar a variável, clique em **Criar** . Você pode adicionar várias variáveis ​​a um aplicativo.![](https://help.vwo.com/hc/article_attachments/360030937033/blobid3.jpg)
    
Você pode visualizar o fragmento de código Java, Objetivo ou Swift relevante no painel direito enquanto cria a variável. Você pode usar este snippet de código para atualizar as alterações no código do seu aplicativo móvel.

**Por exemplo,** vamos considerar que você deseja criar um teste A / B para seu aplicativo móvel para os seguintes casos de uso:

-   **Controle** : exige que os usuários façam login (após a inscrição) no aplicativo para fazer uma reserva.   
-   **Variação** : os usuários podem fazer o pagamento diretamente sem fazer login.

Para criar uma variável para o caso de uso, vá para a seção **Criar Variável** no painel do VWO Mobile App.![](https://help.vwo.com/hc/article_attachments/360030937013/blobid4.jpg)

-   Insira um nome de variável, **por exemplo,** askForLogin.
-   Selecione o tipo de dados como booleano.
-   Insira um valor padrão e clique em Criar. **Por exemplo,** se o seu aplicativo requer login para reservar, selecione o valor como verdadeiro ou falso se o login não for necessário.
-   Para testar a variável askForLogin, clique em Adicionar variação para adicionar a variação e definir o valor padrão da variação. **Por exemplo,** para testar askForLogin sem inscrição, defina o valor padrão da variação como falso.

Conclua o processo de criação do teste iniciando o rastreamento de dados para o cenário.

## Teste

O Teste A/B disponível na plataforma, possibilita a criação de teste A/V de acesso/ações, variações de variáveis e de totalização de receita. Abaixo é descrito todas estas possibilidades

1.  Na tela de teste A / B do aplicativo móvel, vá para a guia Campanhas e clique em **Criar** .![](https://help.vwo.com/hc/article_attachments/360030937073/blobid5.jpg)
    
2.  Escolha o aplicativo que deseja testar. Todos os aplicativos móveis que você adicionou ao VWO estão listados aqui.
3.  Selecione uma plataforma onde o aplicativo está sendo executado.
4.  Insira um identificador exclusivo no campo Definir uma chave de teste para filtrar seus testes facilmente. A chave de teste ajuda a executar a lógica personalizada, conforme explicado nesta seção de [blocos de código](https://developers.vwo.com/reference#code-blocks) .![](https://help.vwo.com/hc/article_attachments/360030937133/blobid6.jpg)
    
5.  Clique em **SEGUINTE** .
6.  Clique em **Adicionar variável** . Todas as variáveis ​​que você criou para o teste são exibidas aqui. Você pode escolher criar uma variável adicionando uma nova variável de teste.![](https://help.vwo.com/hc/article_attachments/360030937093/blobid7.jpg)
    
7.  Selecione a variável que deseja testar e, a seguir, insira os valores de variação. Você pode testar várias variáveis ​​em um teste. No exemplo acima, adicionamos a variável de velocidade, valor definido como 20 para a variação. Para controle, o valor é 10, que é o valor padrão da variável. O VWO gera o snippet de código que você pode usar no aplicativo móvel com base na chave de teste e nos nomes de variação.
	
    **Observação**: também é possível fazer validação apenas de variações, sem adicionar nenhuma variável, mas, para este tipo de caso, será necessário adicionar uma validação da variação diretamente no código, como o exemplo abaixo:
```swift
let variation = VWO.variationNameFor(testKey: "<campaign-key>")
switch variation {
    case "Control":
        // Code for Control
        break
    case "Variation-1":
        // Code for Variation-1
        break
    case "Variation-2":
        // Code for Variation-2
        break
    case "Variation-3":
        // Code for Variation-3
        break
    default: break
}
```

8.  Para continuar, clique em **SEGUINTE** .

#### **Adicionar metas de conversão**

Na seção Metas, adicione as metas que deseja medir para as variáveis ​​de teste adicionadas aos testes. As metas de conversão ajudam a medir o sucesso do seu teste. Defina metas para rastrear os eventos de conversão relevantes para sua necessidade.![](https://help.vwo.com/hc/article_attachments/360030937153/blobid8.jpg)

Você pode adicionar os seguintes tipos de meta:

-   **Gera receita:** rastreia a receita de compras ou vendas feitas por meio de seu aplicativo, definindo um valor para cada transação bem-sucedida.
```swift
VWO.trackConversion("<goal-key>", value: Double)
```
-   **Acionar conversão personalizada:** rastreia a conversão de metas em qualquer evento personalizado, como toques, visualizações de página ou qualquer outra ação do usuário. **Por exemplo,** você pode definir uma meta de conversão personalizada para rastrear toques no evento pop-up de seu aplicativo ou rastrear quantos usuários visualizaram o pop-up.
```swift
VWO.trackConversion("<goal-key>")
```
