# Flix2You - Desafio Back-end da Mobile2You
[<img src="/public/mobile2you.png"/>](/public/mobile2you.png)

## Sobre o projeto

API desenvolvida para listagem de filmes e atualização de catálogo

## Preparação de ambiente

```bash
bin/setup
```

## API

### Filmes

#### Listar todos os filmes

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