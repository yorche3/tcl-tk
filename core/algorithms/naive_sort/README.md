# Naive Sort — Tcl/Tk

Implementación de la especificación [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) en **Tcl/Tk**, usando una estructura tipo librería con `src/` y `test/`, y **Tcltest** como framework de pruebas unitarias.

Los tres algoritmos elementales de ordenamiento $O(n^2)$ — **selection sort**, **bubble sort** e **insertion sort** — reciben una lista de enteros y devuelven una lista nueva ordenada, sin invocar `lsort` ni ninguna otra ayuda de ordenamiento de la biblioteca estándar. Tk no es necesario para este módulo porque no se crea una interfaz gráfica.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`src/naive_sort.tcl`](src/naive_sort.tcl) | Namespace `NaiveSort` con los 3 procedimientos del contrato. |
| [`src/pkgIndex.tcl`](src/pkgIndex.tcl) | Registro del paquete `naive_sort 1.0`. |
| [`test/naive_sort.test`](test/naive_sort.test) | Suite Tcltest: 3 algoritmos × 7 casos. |
| [`.gitignore`](.gitignore) | Ignora logs de Tcltest. |

```text
naive_sort/
├── src/
│   ├── naive_sort.tcl
│   └── pkgIndex.tcl
├── test/
│   └── naive_sort.test
├── .gitignore
└── README.md
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente como una librería Tcl, igual que `core/foundations/numbers/`: `src/naive_sort.tcl` define el namespace `NaiveSort` y publica el paquete con `package provide`, y `pkgIndex.tcl` permite cargarlo con `package require`. Las pruebas usan Tcltest, el framework incluido en la distribución.

**EN:** The project was created by hand as a Tcl library, like `core/foundations/numbers/`: `src/naive_sort.tcl` defines the `NaiveSort` namespace and publishes the package with `package provide`, and `pkgIndex.tcl` lets Tcl load it with `package require`. Tests use Tcltest, the framework shipped with the distribution.

### Inicialización / Initialization

```bash
mkdir -p tcl-tk/core/algorithms/naive_sort/{src,test}
# Escribir src/naive_sort.tcl, src/pkgIndex.tcl y test/naive_sort.test
```

---

## 📄 Configuración clave / Key Configuration

### `src/pkgIndex.tcl` — registro del paquete

```tcl
package ifneeded naive_sort 1.0 [list source [file join $dir naive_sort.tcl]]
```

### `src/naive_sort.tcl` — contrato e implementación

**ES:** Los tres procedimientos reciben una lista de enteros y devuelven una lista nueva ordenada. Con menos de dos elementos la lista vuelve sin cambios y ningún procedimiento lanza errores.

**EN:** The three procedures take a list of integers and return a new sorted list. With fewer than two elements the list is returned unchanged and no procedure raises an error.

```tcl
namespace eval NaiveSort {
    namespace export selection_sort bubble_sort insertion_sort

    proc selection_sort {array} {
        set n [llength $array]
        if {$n <= 1} {
            return $array
        }
        set result $array
        for {set i 0} {$i < $n - 1} {incr i} {
            set minIndex $i
            for {set j [expr {$i + 1}]} {$j < $n} {incr j} {
                if {[lindex $result $j] < [lindex $result $minIndex]} {
                    set minIndex $j
                }
            }
            if {$minIndex != $i} {
                set temp [lindex $result $i]
                lset result $i [lindex $result $minIndex]
                lset result $minIndex $temp
            }
        }
        return $result
    }
}

package provide naive_sort 1.0
```

| Elemento del contrato | Representación en Tcl |
| --------------------- | --------------------- |
| Lista de enteros | `{5 2 9 1 5 6}` (índices 0-based) |
| Caso nulo / inválido | Omitido: Tcl no tiene `null`/`nil` y `{}` no se distingue de una cadena vacía |
| Lista vacía | `{}` |
| Orden | sobre una copia local, devuelve una lista nueva ordenada |
| Nombres de la especificación | `selection_sort`, `bubble_sort`, `insertion_sort` (snake_case, idénticos a la especificación y al namespace `Numbers`) |

### Suite de pruebas / Test suite

**ES:** La suite carga el paquete con `package require`, guarda los fixtures en constantes, los agrupa en la tabla `cases` y usa un helper compartido que recibe el nombre del algoritmo y el comando a probar; cada caso se declara con `test … -body … -result …` y el mensaje del contrato va en la descripción.

**EN:** The suite loads the package with `package require`, keeps the fixtures in constants, groups them in the `cases` table, and uses a shared helper that receives the algorithm name and the command under test; each case is declared with `test … -body … -result …` and the contract message goes in the description.

```tcl
proc assert_sorts_all_cases {algorithm function} {
    foreach testCase $::cases {
        lassign $testCase description input expected

        test "$algorithm: $description" "$algorithm should sort $description" \
            -body [list $function $input] \
            -result $expected
    }
}
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisitos / Requirements

- **Tcl 9.0.4** (`tclsh9.0`) y **Tcltest 2.5.11**, ambos incluidos en la instalación de Tcl del entorno.

```bash
source "$HOME/.bashrc"
tclsh9.0 <<< 'puts [info patchlevel]'
tclsh9.0 <<< 'puts [package require tcltest]'
```

### Cargar el paquete y ejecutar las pruebas / Load the package & run tests

**ES:** El paquete se localiza con `TCLLIBPATH` apuntando a `src/`, y la suite se ejecuta desde `test/`.

**EN:** The package is located with `TCLLIBPATH` pointing at `src/`, and the suite runs from `test/`.

```bash
cd tcl-tk/core/algorithms/naive_sort/test

# Verificar que el paquete carga y expone los 3 comandos
TCLLIBPATH="$(cd ../src && pwd)" tclsh9.0 <<< 'package require naive_sort 1.0; puts [info commands ::NaiveSort::*]'

# Ejecutar la suite
TCLLIBPATH="$(cd ../src && pwd)" tclsh9.0 naive_sort.test
```

**Salida real / Actual output:**

```text
$ TCLLIBPATH="$(cd ../src && pwd)" tclsh9.0 <<< 'package require naive_sort 1.0; puts [info commands ::NaiveSort::*]'
::NaiveSort::selection_sort ::NaiveSort::insertion_sort ::NaiveSort::bubble_sort
```

```text
$ TCLLIBPATH="$(cd ../src && pwd)" tclsh9.0 naive_sort.test
naive_sort.test:        Total   21      Passed  21      Skipped 0       Failed 0
```

> **ES:** 21 casos = 3 algoritmos × 7 casos. Tcl no tiene compilador ni analizador estático, así que la verificación es la carga del paquete y la ejecución de la suite; Tcltest imprime el resumen final con el total, los aprobados y los fallidos.
> **EN:** 21 cases = 3 algorithms × 7 cases. Tcl has no compiler or static analyser, so verification is loading the package and running the suite; Tcltest prints the final summary with the total, passed, and failed counts.

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Función / Algorithm | Enfoque / Approach | Descripción / Description |
| ------------------- | ------------------ | ------------------------- |
| `selection_sort(array)` | iterativo, con `lset` | Busca el mínimo del tramo no ordenado con `minIndex` y lo intercambia al inicio con `lset`. $O(n^2)$ siempre. |
| `bubble_sort(array)` | iterativo, con bandera | Compara adyacentes e intercambia con `lset`; sale antes cuando `swapped` queda en 0. $O(n^2)$ peor/promedio, $O(n)$ mejor. |
| `insertion_sort(array)` | iterativo, estable | Inserta cada elemento desplazándolo hacia la izquierda mientras el vecino sea estrictamente mayor. $O(n^2)$ peor/promedio, $O(n)$ mejor. |

| Caso (descripción en la suite) | Entrada | Salida esperada |
| ------------------------------ | ------- | --------------- |
| an unsorted array | `{5 2 9 1 5 6}` | `{1 2 5 5 6 9}` |
| an already sorted array | `{1 2 3 4 5}` | `{1 2 3 4 5}` |
| a reverse ordered array | `{5 4 3 2 1}` | `{1 2 3 4 5}` |
| an array of identical elements | `{7 7 7 7}` | `{7 7 7 7}` |
| an array with negative numbers | `{3 -1 4 -5 0}` | `{-5 -1 0 3 4}` |
| a single element array | `{42}` | `{42}` |
| an empty array | `{}` | `{}` |

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Divergencia idiomática aceptada: los algoritmos trabajan sobre una **copia local** (`set result $array`) y devuelven una lista nueva ordenada, variante que la especificación permite («in-place o retornando una copia ordenada»). Las listas de Tcl son valores, así que cada llamada recibe su propia copia y los fixtures de la suite no se modifican.
- **EN:** Accepted idiomatic divergence: the algorithms work on a **local copy** (`set result $array`) and return a new sorted list, a variant the specification allows ("in-place or returning a sorted copy"). Tcl lists are values, so each call receives its own copy and the suite fixtures are not modified.
- **ES:** Caso nulo omitido: Tcl no tiene `null`/`nil` y `{}` es a la vez la lista vacía y la cadena vacía, así que una entrada nula no es representable y no hay indicador de fallo que comprobar; se conservan los 7 casos de la especificación. Ningún procedimiento lanza errores.
- **EN:** Null case omitted: Tcl has no `null`/`nil` and `{}` is both the empty list and the empty string, so a null input is not representable and there is no indicator to check; the 7 cases of the specification are kept. No procedure raises an error.
- **ES:** Los intercambios se hacen con `lset` sobre la copia local, leyendo antes el valor que se va a sobrescribir; no se invoca `lsort`, `lsort -command` ni ninguna otra ayuda de ordenamiento de la biblioteca estándar.
- **EN:** Swaps are done with `lset` on the local copy, reading the value that will be overwritten first; `lsort`, `lsort -command`, or any other standard-library sorting helper is never called.
- **ES:** `bubble_sort` conserva la optimización de salida temprana: la bandera `swapped` y el `break` reproducen el `if not swapped: break` del pseudocódigo (mejor caso $O(n)$). La bandera no es observable en la salida, así que su presencia se verifica contra el pseudocódigo.
- **EN:** `bubble_sort` keeps the early-exit optimization: the `swapped` flag and the `break` reproduce the pseudocode's `if not swapped: break` (best case $O(n)$). The flag is not observable in the output, so its presence is verified against the pseudocode.
- **ES:** Los bucles del pseudocódigo se traducen a `for {set i 0} {$i < $n - 1} {incr i}` con bucles interiores `$j < $n` y `$j < $n - 1 - $i` (el equivalente exacto de `for j = 0 to n - 2 - i`).
- **EN:** The pseudocode loops translate to `for {set i 0} {$i < $n - 1} {incr i}` with inner loops `$j < $n` and `$j < $n - 1 - $i` (the exact equivalent of `for j = 0 to n - 2 - i`).
- **ES:** `insertion_sort` implementa la inserción desplazando el elemento hacia la izquierda mientras el vecino sea estrictamente mayor (`[lindex $result $j] < [lindex $result [expr {$j - 1}]]`); es equivalente al desplazamiento del pseudocódigo y la comparación estricta lo mantiene estable.
- **EN:** `insertion_sort` implements insertion by moving the element left while its neighbour is strictly greater (`[lindex $result $j] < [lindex $result [expr {$j - 1}]]`); it is equivalent to the pseudocode's shifting and the strict comparison keeps it stable.
- **ES:** Nota de desviación respecto a la ubicación esperada: se conserva `src/naive_sort.tcl` (solo cambia la extensión) y la suite se llama `test/naive_sort.test`, el sufijo que ya usan `numbers/` y `calculator/`; no se añade `run_tests.tcl` porque Tcltest es el runner y el resumen final de cada suite hace de informe. El paquete exige `TCLLIBPATH` apuntando a `src/`, que es el mecanismo estándar de Tcl para localizar `pkgIndex.tcl`.
- **EN:** Deviation note from the expected location: `src/naive_sort.tcl` is kept (only the extension changes) and the suite is named `test/naive_sort.test`, the suffix already used by `numbers/` and `calculator/`; no `run_tests.tcl` is added because Tcltest is the runner and each suite's final summary acts as the report. The package requires `TCLLIBPATH` pointing at `src/`, the standard Tcl mechanism for locating `pkgIndex.tcl`.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*[← Volver a Algoritmos Puros](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
