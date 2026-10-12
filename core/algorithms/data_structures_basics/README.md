# Data Structures Basics — Tcl/Tk

Implementación de la especificación [06_Data_Structures_Basics](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) en **Tcl/Tk**, usando una estructura tipo librería con `src/` y `test/`, y **Tcltest** como framework de pruebas unitarias.

**ES:** Cuatro clases de TclOO construidas a mano sobre un único tipo `Node`: `Node`, `LinkedList`, `Stack` y `Queue` bajo el namespace `DataStructuresBasics`. Cada estructura gestiona directamente sus punteros y contador; `Stack` y `Queue` no delegan en `LinkedList` ni en estructuras estándar de Tcl.

**EN:** Four TclOO classes built by hand over a single `Node` type: `Node`, `LinkedList`, `Stack`, and `Queue` under the `DataStructuresBasics` namespace. Each ADT directly manages its pointers and count; `Stack` and `Queue` do not delegate to `LinkedList` or standard Tcl data structures.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directory | Propósito / Purpose |
|---|---|
| [`src/data_structures_basics.tcl`](src/data_structures_basics.tcl) | Implementación de las clases TclOO `Node`, `LinkedList`, `Stack` y `Queue`. / Implementation of TclOO classes `Node`, `LinkedList`, `Stack`, and `Queue`. |
| [`src/pkgIndex.tcl`](src/pkgIndex.tcl) | Registro del paquete `data_structures_basics 1.0`. / Package index registration for `data_structures_basics 1.0`. |
| [`test/data_structures_basics.test`](test/data_structures_basics.test) | Suite de pruebas unitarias con Tcltest cubriendo las cuatro estructuras. / Unit test suite using Tcltest covering all four data structures. |
| [`.gitignore`](.gitignore) | Exclusiones locales de Git (archivos temporales y artefactos). / Local Git exclusions (temporary files and artifacts). |

**Estructura de directorios / Directory structure:**

```text
data_structures_basics/
├── src/
│   ├── data_structures_basics.tcl
│   └── pkgIndex.tcl
├── test/
│   └── data_structures_basics.test
├── .gitignore
└── README.md
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se estructuró manualmente como una librería Tcl siguiendo el patrón modular `src/` y `test/`:
1. `src/data_structures_basics.tcl` declara las dependencias (`package require Tcl 8.6-` y `package require TclOO`), define el namespace `DataStructuresBasics` con sus cuatro clases (`Node`, `LinkedList`, `Stack`, `Queue`), y publica el paquete `data_structures_basics 1.0`.
2. `src/pkgIndex.tcl` asocia la provisión del paquete `data_structures_basics 1.0` con la carga de `data_structures_basics.tcl`.
3. `test/data_structures_basics.test` utiliza el framework nativo **Tcltest** para verificar el comportamiento acumulativo y los casos de prueba de cada estructura.

**EN:** The project was created manually as a Tcl library following the modular `src/` and `test/` pattern:
1. `src/data_structures_basics.tcl` declares requirements (`package require Tcl 8.6-` and `package require TclOO`), defines namespace `DataStructuresBasics` with its four classes (`Node`, `LinkedList`, `Stack`, `Queue`), and provides package `data_structures_basics 1.0`.
2. `src/pkgIndex.tcl` associates providing package `data_structures_basics 1.0` with sourcing `data_structures_basics.tcl`.
3. `test/data_structures_basics.test` uses the native **Tcltest** framework to verify cumulative state transitions and test cases for each structure.

---

## 📄 Configuración clave / Key Configuration

### `src/pkgIndex.tcl`

```tcl
package ifneeded data_structures_basics 1.0 [list source [file join $dir data_structures_basics.tcl]]
```

Permite cargar el paquete mediante `package require data_structures_basics 1.0` cuando `TCLLIBPATH` incluye el directorio `src/`.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **Tcl 8.6+** o **Tcl 9.0.4** (`tclsh` / `tclsh9.0`).
- **TclOO** (integrado en el núcleo de Tcl desde 8.6).
- **Tcltest 2.5+** (incluido en la distribución estándar de Tcl).

```bash
# Verificación de entorno / Environment check
tclsh9.0 <<< 'puts [info patchlevel]'
tclsh9.0 <<< 'puts [package require tcltest]'
```

### Cargar el paquete y ejecutar las pruebas / Load package & run tests

```bash
cd test

# Verificación de carga y exportación / Verification of package loading and exports
TCLLIBPATH="$(cd ../src && pwd)" tclsh9.0 <<< 'package require data_structures_basics 1.0; puts [info commands ::DataStructuresBasics::*]'

# Ejecución de la suite Tcltest / Run Tcltest suite
TCLLIBPATH="$(cd ../src && pwd)" tclsh9.0 data_structures_basics.test
```

**Salida real / Actual output:**

```text
$ TCLLIBPATH="$(cd ../src && pwd)" tclsh9.0 <<< 'package require data_structures_basics 1.0; puts [info commands ::DataStructuresBasics::*]'
::DataStructuresBasics::Queue ::DataStructuresBasics::Stack ::DataStructuresBasics::Node ::DataStructuresBasics::LinkedList
```

```text
$ TCLLIBPATH="$(cd ../src && pwd)" tclsh9.0 data_structures_basics.test
data_structures_basics.test:	Total	19	Passed	19	Skipped	0	Failed	0
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

### `Node`

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `[Node new $value]` | `value → Node` | $O(1)$ | Constructor (`init`); guarda el valor y deja `next` ausente (`{}`). / Constructor (`init`); stores value and leaves `next` absent (`{}`). |
| `$node get_value` | `void → value` | $O(1)$ | Retorna el valor contenido en la celda. / Returns the value contained in the cell. |
| `$node get_next` | `void → Node \| {}` | $O(1)$ | Retorna el enlace al siguiente nodo o `{}` si ausente. / Returns the link to the next node or `{}` when absent. |
| `$node set_next $next` | `Node \| {} → Node \| {}` | $O(1)$ | Modifica el puntero siguiente de la celda y lo devuelve. / Updates the next pointer of the cell and returns it. |

### `LinkedList`

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `[LinkedList new]` | `void → LinkedList` | $O(1)$ | Constructor (`init`); `head` y `tail` vacíos (`{}`), contador `0`. / Constructor (`init`); `head` and `tail` empty (`{}`), count `0`. |
| `$list get_head` | `void → value \| -1` | $O(1)$ | Retorna el valor de la cabeza, o `-1` si está vacía. / Returns head value, or `-1` if empty. |
| `$list insert_head $value` | `value → {}` | $O(1)$ | Inserta nodo en la cabeza; actualiza `head`, `tail` y contador. / Inserts node at head; updates `head`, `tail`, and count. |
| `$list insert_tail $value` | `value → {}` | $O(1)$ | Inserta nodo en la cola; actualiza `tail`, `head` y contador. / Inserts node at tail; updates `tail`, `head`, and count. |
| `$list delete $value` | `value → 0 \| 1` | $O(n)$ | Elimina la primera aparición de `value`; retorna `1` en éxito, `0` si no se encontró. / Deletes first occurrence of `value`; returns `1` on success, `0` if not found. |
| `$list is_empty` | `void → 0 \| 1` | $O(1)$ | Retorna `1` si `head` es vacía (`{}`), `0` en caso contrario. / Returns `1` if `head` is empty (`{}`), `0` otherwise. |
| `$list size` | `void → int` | $O(1)$ | Retorna el número de nodos almacenados. / Returns the number of stored nodes. |

### `Stack`

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `[Stack new]` | `void → Stack` | $O(1)$ | Constructor (`init`); `top` vacío (`{}`), contador `0`. / Constructor (`init`); `top` empty (`{}`), count `0`. |
| `$stack push $value` | `value → {}` | $O(1)$ | Apila un nuevo nodo sobre `top` e incrementa contador. / Pushes a new node onto `top` and increments count. |
| `$stack pop` | `void → value \| -1` | $O(1)$ | Desapila y retorna el valor de `top`, o `-1` si está vacía. / Pops and returns `top` value, or `-1` if empty. |
| `$stack peek` | `void → value \| -1` | $O(1)$ | Observa el valor de `top` sin desapilar, o `-1` si está vacía. / Observes `top` value without popping, or `-1` if empty. |
| `$stack is_empty` | `void → 0 \| 1` | $O(1)$ | Retorna `1` si `top` es vacía (`{}`), `0` en caso contrario. / Returns `1` if `top` is empty (`{}`), `0` otherwise. |
| `$stack size` | `void → int` | $O(1)$ | Retorna el número de elementos apilados. / Returns the number of stacked elements. |

### `Queue`

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `[Queue new]` | `void → Queue` | $O(1)$ | Constructor (`init`); `front` y `rear` vacíos (`{}`), contador `0`. / Constructor (`init`); `front` and `rear` empty (`{}`), count `0`. |
| `$queue enqueue $value` | `value → {}` | $O(1)$ | Encola un nuevo nodo tras `rear` e incrementa contador. / Enqueues a new node after `rear` and increments count. |
| `$queue dequeue` | `void → value \| -1` | $O(1)$ | Desencola y retorna el valor de `front`, o `-1` si está vacía. / Dequeues and returns `front` value, or `-1` if empty. |
| `$queue peek` | `void → value \| -1` | $O(1)$ | Observa el valor de `front` sin desencolar, o `-1` si está vacía. / Observes `front` value without dequeueing, or `-1` if empty. |
| `$queue is_empty` | `void → 0 \| 1` | $O(1)$ | Retorna `1` si `front` es vacía (`{}`), `0` en caso contrario. / Returns `1` if `front` is empty (`{}`), `0` otherwise. |
| `$queue size` | `void → int` | $O(1)$ | Retorna el número de elementos encolados. / Returns the number of queued elements. |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| TclOO (`oo::class`) con nombres cualificados `::DataStructuresBasics::Node` | Diccionarios nativos (`dict`) o listas | TclOO encapsula estado mutable y punteros de referencia de forma limpia y directa. Los métodos de TclOO ejecutan en namespaces de objeto (`::oo::ObjNN`), por lo que referenciar `::DataStructuresBasics::Node` evita ambigüedad de resolución de comandos. / TclOO cleanly encapsulates mutable state and object reference pointers. TclOO methods execute inside object namespaces (`::oo::ObjNN`), so qualifying `::DataStructuresBasics::Node` prevents command resolution issues. |
| Constructores `constructor` como `init` | Métodos `init` separados después de instanciar | En TclOO la instanciación e inicialización se producen conjuntamente mediante `[Class new]`, garantizando invariantes válidos desde la creación sin estados intermedios no inicializados. / In TclOO instantiation and initialization happen together via `[Class new]`, guaranteeing valid invariants from creation without uninitialized intermediate states. |
| Destrucción explícita de objetos de prueba con `$obj destroy` | Dejar los objetos en memoria hasta fin de script | Libera los comandos de instancia en el intérprete de Tcl garantizando ausencia de fugas durante las pruebas unitarias. / Releases instance commands in the Tcl interpreter guaranteeing no leaks during unit testing. |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| `init` de `Node`, `LinkedList`, `Stack` y `Queue` | `constructor` de TclOO invocado con `[Class new ...]` | En TclOO la inicialización se asocia directamente a la construcción del objeto mediante `constructor`. / In TclOO initialization is directly bound to object creation via `constructor`. |
| Ausencia de enlace (`absent`) | Lista/cadena vacía nativa `{}` | Tcl no dispone de `null` ni `nil`; `{}` es la representación nativa de ausencia de valor o enlace sin introducir centinelas artificiales. / Tcl does not have `null` or `nil`; `{}` is the native representation of absent value or reference without introducing artificial sentinels. |
| Indicadores booleanos `true` / `false` | Enteros `1` / `0` | En Tcl las expresiones booleanas y condiciones se evalúan numéricamente como `1` y `0`. / In Tcl boolean expressions and conditions evaluate numerically to `1` and `0`. |
| Indicador de fallo en consulta de estructuras vacías | Entero centinela `-1` | Tcl no tipa fuertemente el retorno; `-1` es un entero no ambiguo en el dominio de pruebas de enteros positivos que no colisiona con valores válidos ni lanza errores. / Tcl has no static types; `-1` is an unambiguous integer in the positive integer test domain that avoids collisions and avoids raising errors. |
| Ubicación esperada: `test/data_structures_basics_test.ext` y `run_tests.ext` | `test/data_structures_basics.test` | Extensión estándar `.test` de Tcltest, que actúa como su propio runner de pruebas emitiendo el resumen final. / Standard `.test` extension for Tcltest, which acts as its own test runner emitting the final summary. |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `Node get_next` | Enlace siguiente ausente | `{}` | `[$node get_next]` → `{}` |
| `LinkedList get_head` | Lista vacía | `-1` | `[$list get_head]` → `-1` |
| `LinkedList delete` | Valor no encontrado en la lista | `0` | `[$list delete 99]` → `0` |
| `Stack peek` | Pila vacía | `-1` | `[$stack peek]` → `-1` |
| `Stack pop` | Pila vacía | `-1` | `[$stack pop]` → `-1` |
| `Queue peek` | Cola vacía | `-1` | `[$queue peek]` → `-1` |
| `Queue dequeue` | Cola vacía | `-1` | `[$queue dequeue]` → `-1` |

---

## ✅ Cobertura de pruebas / Test coverage

### `Node`

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Inicializar y observar valor/enlace<br>Initialize and observe value/link | Sí | `test/data_structures_basics.test:67-87` (`data-structures-basics-node-*`) | Comprueba `get_value == 10` y `get_next == {}`. / Verifies `get_value == 10` and `get_next == {}`. |
| Inicializar otro nodo, enlazar y recorrer<br>Initialize another node, link and traverse | Sí | `test/data_structures_basics.test:67-87` (`data-structures-basics-node-*`) | Comprueba enlace `a -> b`, `[[$a get_next] get_value] == 20` y `get_next(b) == {}`. / Verifies `a -> b` link, `[[$a get_next] get_value] == 20`, and `get_next(b) == {}`. |

### `LinkedList`

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Estado vacío<br>Empty state | Sí | `test/data_structures_basics.test:89-138` (`data-structures-basics-linked-list-*`) | Comprueba `is_empty == 1`, `size == 0` y `get_head == -1`. / Checks `is_empty == 1`, `size == 0`, and `get_head == -1`. |
| Insertar por ambos extremos<br>Insert at both ends | Sí | `test/data_structures_basics.test:89-138` (`data-structures-basics-linked-list-*`) | Inserta cola 10, 20; cabeza 5; cola 10; verifica `size == 4` y `get_head == 5`. / Inserts tail 10, 20; head 5; tail 10; checks `size == 4` and `get_head == 5`. |
| Eliminar primera aparición<br>Delete first occurrence | Sí | `test/data_structures_basics.test:89-138` (`data-structures-basics-linked-list-*`) | `delete 10` retorna 1; verifica `size == 3` y `get_head == 5`. / `delete 10` returns 1; checks `size == 3` and `get_head == 5`. |
| Valor ausente<br>Absent value | Sí | `test/data_structures_basics.test:89-138` (`data-structures-basics-linked-list-*`) | `delete 99` retorna 0; verifica tamaño y cabeza inalterados. / `delete 99` returns 0; checks size and head unchanged. |
| Vaciar<br>Empty the list | Sí | `test/data_structures_basics.test:89-138` (`data-structures-basics-linked-list-*`) | `delete 5`, `delete 20`, `delete 10` retornan 1; verifica `is_empty == 1`, `size == 0` y `get_head == -1`. / `delete 5`, `delete 20`, `delete 10` return 1; checks `is_empty == 1`, `size == 0`, and `get_head == -1`. |

### `Stack`

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Estado vacío y extracción fallida<br>Empty state and failed removal | Sí | `test/data_structures_basics.test:140-178` (`data-structures-basics-stack-*`) | Comprueba `is_empty == 1`, `size == 0`, `peek == -1` y `pop == -1`. / Verifies `is_empty == 1`, `size == 0`, `peek == -1`, and `pop == -1`. |
| LIFO y `peek` no mutante<br>LIFO and non-mutating `peek` | Sí | `test/data_structures_basics.test:140-178` (`data-structures-basics-stack-*`) | Apila 10, 20, 30; comprueba `peek == 30` y `size == 3`. / Pushes 10, 20, 30; checks `peek == 30` and `size == 3`. |
| Extracción y reutilización<br>Removal and reuse | Sí | `test/data_structures_basics.test:140-178` (`data-structures-basics-stack-*`) | Desapila 30, apila 40, desapila 40, 20, 10; verifica `is_empty == 1` y `size == 0`. / Pops 30, pushes 40, pops 40, 20, 10; verifies `is_empty == 1` and `size == 0`. |
| Vacío tras extracción<br>Empty after removal | Sí | `test/data_structures_basics.test:140-178` (`data-structures-basics-stack-*`) | `pop` sobre pila vacía retorna `-1` y mantiene `is_empty == 1`. / `pop` on empty stack returns `-1` and keeps `is_empty == 1`. |

### `Queue`

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Estado vacío y extracción fallida<br>Empty state and failed removal | Sí | `test/data_structures_basics.test:180-218` (`data-structures-basics-queue-*`) | Comprueba `is_empty == 1`, `size == 0`, `peek == -1` y `dequeue == -1`. / Verifies `is_empty == 1`, `size == 0`, `peek == -1`, and `dequeue == -1`. |
| FIFO y `peek` no mutante<br>FIFO and non-mutating `peek` | Sí | `test/data_structures_basics.test:180-218` (`data-structures-basics-queue-*`) | Encola 10, 20, 30; comprueba `peek == 10` y `size == 3`. / Enqueues 10, 20, 30; checks `peek == 10` and `size == 3`. |
| Extracción y reutilización<br>Removal and reuse | Sí | `test/data_structures_basics.test:180-218` (`data-structures-basics-queue-*`) | Desencola 10, encola 40, desencola 20, 30, 40; verifica `is_empty == 1` y `size == 0`. / Dequeues 10, enqueues 40, dequeues 20, 30, 40; verifies `is_empty == 1` and `size == 0`. |
| Vacío tras extracción<br>Empty after removal | Sí | `test/data_structures_basics.test:180-218` (`data-structures-basics-queue-*`) | `dequeue` sobre cola vacía retorna `-1` y mantiene `is_empty == 1`. / `dequeue` on empty queue returns `-1` and keeps `is_empty == 1`. |

---

## ⚠️ Limitaciones conocidas / Known limitations

Ninguna / None

**ES:** Las estructuras no imponen límites arbitrarios de capacidad y operan dentro de los límites de memoria disponible del intérprete de Tcl, cumpliendo todas las cotas de complejidad $O(1)$ y $O(n)$ exigidas.

**EN:** The structures impose no arbitrary capacity limits and operate within the available memory bounds of the Tcl interpreter, fulfilling all required $O(1)$ and $O(n)$ complexity bounds.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** `Node` es la única celda enlazada compartida del módulo; `LinkedList`, `Stack` y `Queue` no duplican tipos de enlace y cada una gestiona directamente sus punteros (`head`/`tail`, `top`, `front`/`rear`) y contadores sin delegar unas en otras.
- **EN:** `Node` is the single shared linked cell of the module; `LinkedList`, `Stack`, and `Queue` do not duplicate link types and each directly manages its pointers (`head`/`tail`, `top`, `front`/`rear`) and counts without delegating to each other.
- **ES:** En TclOO, las variables de instancia y métodos no acceden automáticamente al namespace léxico exterior durante la ejecución del método (el namespace del objeto es `::oo::ObjNN`), por lo que la instanciación de nodos utiliza la ruta cualificada `::DataStructuresBasics::Node new`.
- **EN:** In TclOO, instance variables and methods do not automatically resolve in the outer lexical namespace during method execution (the object namespace is `::oo::ObjNN`), so node instantiation uses the fully qualified path `::DataStructuresBasics::Node new`.
- **ES:** Los casos nulos o ausentes se representan mediante la cadena/lista vacía `{}` de Tcl; ningún método invoca `error` ni lanza excepciones ante operaciones en estado vacío, retornando los indicadores de fallo representables estipulados.
- **EN:** Null or absent cases are represented via Tcl's native empty string/list `{}`; no method invokes `error` or raises exceptions on empty state operations, returning the specified representable failure indicators.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

---

## 🔍 Checklist de validación / Validation checklist

- [x] La suite nativa se ejecutó y su salida real está copiada en este README.
- [x] Cada caso de la especificación tiene su fila en _Cobertura de pruebas_.
- [x] Cada desviación del pseudocódigo o de la ubicación esperada está en _Adaptaciones idiomáticas_.
- [x] Cada operación con fallo posible está en _Indicadores de fallo_.
- [x] No hay rutas absolutas del autor, credenciales ni salidas inventadas.
- [x] Los enlaces relativos resuelven dentro del repositorio y el documento es bilingüe.
- [x] Ninguna sección repite lo que ya dice la especificación.

---

## 📚 Referencias / References

| Tipo / Kind | Referencia / Reference |
|---|---|
| Especificación / Specification | [`06_Data_Structures_Basics.md`](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) |
| Módulo homologado del lenguaje / Homologated module | [`tcl-tk/core/foundations/numbers/`](../../foundations/numbers/) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](https://yorche3.github.io/programming_languages/core/00_Project_Initialization_Guide/) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](https://yorche3.github.io/programming_languages/docs/AGENT_Template/) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](https://yorche3.github.io/programming_languages/docs/WORKFLOW/) |
| Documentación oficial del lenguaje / Language official docs | [TclOO Package Documentation](https://www.tcl-lang.org/man/tcl/TclCmd/class.htm) |

---

*[← Volver a 05_Naive_Sort](../naive_sort/) | [↑ Volver a inicio / Back to home](https://yorche3.github.io/programming_languages/)*
