# Flix2You - Desafio Back-end da Mobile2You
[<img src="/public/mobile2you.png"/>](/public/mobile2you.png)

## Sobre o projeto

API desenvolvida para listagem de filmes, séries e programas de TV e atualização de catálogo com arquivo CSV.

## Preparação de ambiente

```bash
bin/setup
```

## API - V1

## Filmes, Séries e Programas de TV

### **Listar todos os filmes, séries e programas de TV**

**Requisição:**

```
GET /api/v1/movies
```

**Resposta:**

```
Status: 200 (OK)

[
    {
        "id": "840c7cfc-cd1f-4094-9651-688457d97fa4",
        "title": "13 Reasons Why",
        "genre": "TV Show",
        "year": "2020",
        "country": "United States",
        "published_at": "2020-05-07",
        "description": "A classmate receives a series of tapes that unravel the mystery of her tragic choice."
    }
]
```

### **Filtrar lista de filmes, séries e programas de TV**

- Os filtros estão de forma dinâmica, ou seja, caso não sejam informados, o sistema exibe a lista completa. Para filtrar, basta usar a combinação da coluna que você quer com o conteúdo a ser buscado. Veja o exemplo abaixo.

**Requisição:**

```
GET /api/v1/movies?title=13 Reasons Why
```

**Resposta:**

```
Status: 200 (OK)

[
    {
        "id": "840c7cfc-cd1f-4094-9651-688457d97fa4",
        "title": "13 Reasons Why",
        "genre": "TV Show",
        "year": "2020",
        "country": "United States",
        "published_at": "2020-05-07",
        "description": "A classmate receives a series of tapes that unravel the mystery of her tragic choice."
    }
]
```

Para usar mais de uma coluna como filtro, basta colocar o & e a coluna seguinte. Veja o exemplo abaixo.

**Requisição:**

```
GET /api/v1/movies?genre=TV Show&year=2020
```

**Resposta:**

```
Status: 200 (OK)

[
    {
        "id": "840c7cfc-cd1f-4094-9651-688457d97fa4",
        "title": "13 Reasons Why",
        "genre": "TV Show",
        "year": "2020",
        "country": "United States",
        "published_at": "2020-05-07",
        "description": "A classmate receives a series of tapes that unravel the mystery of her tragic choice."
    }
]
```

Atualmente é possível filtrar através das seguintes colunas:
- title
- genre
- year
- country


### **Atualizar lista de filmes, séries e programas de TV com arquivo CSV**

**Requisição:**

```
POST /api/v1/movies/update
```

**Alguns detalhes**
- Lembre-se de assegurar que sua requisição ou seu formulário de envio tenha o **content type como multipart/form-data**
- É preciso também estabelecer como **key** da sua requisição ou no seu formulário o seguinte padrão **:movies**
- Não se esqueça de fazer o upload do **arquivo CSV**, com as colunas separadas por **vírgula**

**Resposta:**

```
Status: 201 (OK)

[
    {
        "msg": "O catálogo está atualizado."
    }
]
```