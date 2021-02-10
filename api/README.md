# API

Este diret√rio armazena o script em pyton que ira consumir informa√√es geradas pela API do mediawiki e ira disponibilizar uma pagina web com todas paginas criadas no mediawiki.

O script procurar pelas vari·veis de ambiente "URL" e "API_URL" elas s„o respons·veis por informar qual wiki ser· consultada.

## Modo de usar

```
export URL="http://wiki.vinicius.io/"
export API_URL="http://wiki.vinicius.io/api.php"
python3 app/main.py
```

O script ira abrir a porta 80 para acesso via navegador. Esta configurado para acesso via qualquer interface.
