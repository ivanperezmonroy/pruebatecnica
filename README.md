# Prueba Tecnica
Aplicación iOS desarrollada con Swift, SwiftUI, arquitectura MVVM, persistencia offline con CoreData, consumiendo la Fake Store API.
## Arquitectura
Se utilizó MVVM (Model–View–ViewModel) con separación clara de responsabilidades:
```
Views         -> SwiftUI (UI y navegación)
ViewModels    -> Lógica de presentación y estado
Repositories  -> Fuente única de datos (API + CoreData)
Services      -> Acceso a red y utilidades
Models        -> Entidades del dominio
```
## Patrones utilizados

- MVVM
- Repository Patter
- Dependency Injection
- Offline-first strategy

## API

Fake Store API
https://fakestoreapi.com/docs

Endpoints utilizados:

- /products/categories
- /products/category/{category}
- /products/{id}

## Funcionalidades
### Categorías

- Listado de categorías de productos
- Navegación a productos por categoría

### Productos

- Lista de productos por categoría
- Navegación a detalle de producto

### Detalle de producto

- Imagen
- Título
- Precio
- Descripción
- Marcar / desmarcar como favorito

### Favoritos

- Persistidos en CoreData
- Vista dedicada de productos favoritos
- Disponibles offline

## Soporte Offline (CoreData)

La aplicación funciona sin conexión a internet usando CoreData como almacenamiento local.

### Estrategia

1. Con internet
- Se consume la API
- Se guarda la información en CoreData

2. Sin internet

- Se consulta CoreData
- Se muestran los datos guardados previamente

Los favoritos siempre se guardan localmente.

### Importante

El contenido offline estará disponible solo si fue cargado previamente con conexión. Este comportamiento es intencional y esperado.

## Cómo probar el modo Offline
Opción 1 – Simulador (recomendado)

1. Ejecutar la app en el simulador
2. Cargar categorías y productos con internet
3. En el simulador:

```
Features -> Network -> None
```
4. Reiniciar la app

Opcion 2 - Inhabilitando la red del equipo (MAC)

Resultado esperado:
- Productos visibles
- Detalle de producto funcional
- Favoritos persistentes

## Tecnologías utilizadas

- Swift 6
- SwiftUI
- CoreData
- URLSession
- Network Framework

No se utilizaron librerías externas.

## Notas finales

- Se priorizó la arquitectura, calidad del código y mantenibilidad
- El ViewModel no tiene dependencia directa con SwiftUI
- La lógica offline está encapsulada en el Repository
- La app es fácilmente escalable

## Posibles mejoras

- Cache offline para categorías
- Manejo de errores más detallado en UI
- Pruebas unitarias
- Sincronización incremental

## Autor
Ivan Perez
Prueba técnica iOS
