# Numbers — Tcl/Tk

Implementación de la especificación [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) en **Tcl/Tk**, usando una estructura tipo librería con `src/` y `test/`, y **Tcltest** como framework de pruebas unitarias.

Tk no es necesario para este módulo porque no se crea una interfaz gráfica.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`src/numbers.tcl`](src/numbers.tcl) | Implementación de los 15 procedimientos. |
| [`src/pkgIndex.tcl`](src/pkgIndex.tcl) | Registro del paquete `numbers 1.0`. |
| [`test/recursive.test`](test/recursive.test) | Suite `_rec`: 11 casos agrupados por algoritmo. |
| [`test/iterative.test`](test/iterative.test) | Suite `_ite`: 11 casos agrupados por algoritmo. |
| [`.gitignore`](.gitignore) | Ignora logs de Tcltest. |

```text
numbers/
├── src/
│   ├── numbers.tcl
│   └── pkgIndex.tcl
├── test/
│   ├── recursive.test
│   └── iterative.test
├── .gitignore
└── README.md
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente como una librería Tcl. `src/numbers.tcl` define el namespace `Numbers` y publica el paquete con `package provide`; `pkgIndex.tcl` permite cargarlo con `package require`. Las suites usan Tcltest.

**EN:** The project was created manually as a Tcl library. `src/numbers.tcl` defines the `Numbers` namespace and publishes the package with `package provide`; `pkgIndex.tcl` lets Tcl load it with `package require`. The suites use Tcltest.

Los cinco algoritmos tienen tres implementaciones:

| Enfoque | Sufijo | Ejemplo | ¿Tiene suite propia? |
|---------|--------|---------|:--------------------:|
| Recursivo directo | `_rec` | `fibonacci_rec` | Sí |
| Recursivo con acumulador | `_acc` | `fibonacci_acc` | No, por TCO no garantizada |
| Iterativo | `_ite` | `fibonacci_ite` | Sí |

**Combinación aplicada:** TCO no garantizada + iteración nativa (`for`/`while`) ✅ → `_rec` + `_ite` = **2 suites, 10 tests agrupados y 22 casos**.

**Applied combination:** No guaranteed TCO + native iteration (`for`/`while`) ✅ → `_rec` + `_ite` = **2 suites, 10 grouped tests, and 22 cases**.

### Inicialización / Initialization

```bash
mkdir -p tcl-tk/core/foundations/numbers/{src,test}
cd tcl-tk/core/foundations/numbers
```

Después se escriben el paquete en `src/` y las suites Tcltest en `test/`.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `src/pkgIndex.tcl`

```tcl
package ifneeded numbers 1.0 [list source [file join $dir numbers.tcl]]
```

El índice permite localizar `numbers.tcl` cuando se ejecuta `package require numbers 1.0`.

### Suites Tcltest

Cada suite agrupa los casos por algoritmo: 5 tests por suite contienen 11 aserciones/casos de la especificación. Tcltest proporciona el runner y el reporte mediante `cleanupTests`.

Each suite groups cases by algorithm: 5 tests per suite contain 11 assertions/cases from the specification. Tcltest provides the runner and report through `cleanupTests`.

---

## 🚀 Ejecución / Run

### Requisitos / Requirements

- **Tcl 9.0.4**.
- **Tcltest 2.5.11**, incluido en Tcl.

Verificar:

```bash
tclsh9.0 <<< 'puts [info patchlevel]'
tclsh9.0 <<< 'puts [package require tcltest]'
```

Salida verificada:

```text
9.0.4
2.5.11
```

### Ejecutar la suite recursiva / Run recursive suite

```bash
cd tcl-tk/core/foundations/numbers/test
TCLLIBPATH="$(cd ../src && pwd)" tclsh9.0 recursive.test
```

### Ejecutar la suite iterativa / Run iterative suite

```bash
cd tcl-tk/core/foundations/numbers/test
TCLLIBPATH="$(cd ../src && pwd)" tclsh9.0 iterative.test
```

### Salida esperada / Expected output

Cada suite debe finalizar con un resumen equivalente a:

```text
Total 11       Passed 11       Skipped 0       Failed 0
```

La ejecución conjunta representa 22 casos/assertions aprobados y 0 fallos.

The combined execution represents 22 passed cases/assertions and 0 failures.

---

## 🧠 Operaciones / Operations

| Función | `_rec` | `_acc` | `_ite` |
|---------|--------|--------|--------|
| `sum_of_first_n` | Recursión directa | Helper con acumulador | `for` |
| `factorial` | Recursión directa | Helper con acumulador | `for` |
| `fibonacci` | Dos llamadas recursivas | Dos acumuladores | `for` |
| `greatest_common_divisor` | Euclides recursivo | Helper de Euclides | `while` |
| `least_common_multiple` | Usa MCD y aritmética | Usa MCD y aritmética | Usa MCD y aritmética |

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Tcl dispone de `for` y `while`, por lo que `_ite` se implementa sin llamadas recursivas.
- **EN:** Tcl provides `for` and `while`, so `_ite` is implemented without recursive calls.
- **ES:** Tcl no ofrece una garantía general de TCO para este proyecto; `_acc` se conserva como puente didáctico sin suite propia.
- **EN:** Tcl does not provide a general TCO guarantee for this project; `_acc` remains as an educational bridge without its own suite.
- **ES:** Tcltest no requiere un `run_tests.tcl` adicional; `cleanupTests` produce el resumen y el estado de salida.
- **EN:** Tcltest does not require an additional `run_tests.tcl`; `cleanupTests` produces the summary and exit status.
- **ES:** Los archivos `.log` generados por las pruebas quedan excluidos mediante `.gitignore`.
- **EN:** Test-generated `.log` files are excluded through `.gitignore`.
- **ES:** El código fuente no incluye comentarios inline; la explicación se mantiene en este README.
- **EN:** The source code contains no inline comments; explanations are kept in this README.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://github.com/yorche3/programming_languages)*
