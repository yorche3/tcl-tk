# naive_sort — ordenamientos elementales O(n²).
#
# Especificación: 05_Naive_Sort
#
# Contrato: las tres funciones reciben una lista de enteros y devuelven una lista
# nueva ordenada de menor a mayor, sin invocar `lsort` ni ninguna otra ayuda de
# ordenamiento de la biblioteca estándar y sin estructuras auxiliares complejas.
# Las listas de Tcl son valores, así que el resultado vuelve por el valor
# devuelto.
# API: los tres comandos del namespace `NaiveSort` — `selection_sort`,
# `bubble_sort` e `insertion_sort`, con los nombres `snake_case` de la
# especificación, como en el namespace `Numbers` de `core/foundations/numbers/`.
# El caso nulo se omite: Tcl no tiene `null`/`nil` y la lista vacía (`{}`) no se
# distingue de una cadena vacía. Si la lista está vacía o tiene un solo elemento
# se devuelve sin cambios. No lanza excepciones.
#
# Implementación pendiente: la escribe el autor. Esta delegación solo genera el
# esqueleto y las pruebas unitarias.

namespace eval NaiveSort {
    namespace export selection_sort bubble_sort insertion_sort

    
}

package provide naive_sort 1.0
