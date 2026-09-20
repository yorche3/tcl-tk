# 🚀 Algoritmos Puros / Algorithms Pure — Tcl/Tk

Implementaciones de la [Fase 1 — Algoritmos Puros](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-) en **Tcl/Tk**: ordenamientos elementales, estructuras de datos propias, ordenamientos óptimos y distribuidos, y búsqueda.

Los módulos de esta fase trabajan sobre **listas de Tcl**, que son valores: los algoritmos ordenan una copia local y devuelven una lista nueva ordenada. Tcl no tiene `null`/`nil`, así que el caso nulo no es representable y la lista vacía (`{}`) es a la vez la lista vacía y la cadena vacía.

---

## 📂 Módulos / Modules

| Módulo | Especificación | Enfoque | Tests | Estado |
|--------|---------------|---------|:-----:|:------:|
| [`naive_sort/`](naive_sort/) | [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) | `tclsh9.0 <suite>.test` (Tcltest) | 21 | ✅ |

---

## 📁 Estructura / Structure

```text
algorithms/
└── naive_sort/                  # 05_Naive_Sort
    ├── .gitignore               # *.log
    ├── src/
    │   ├── naive_sort.tcl       # namespace NaiveSort: 3 procedimientos
    │   └── pkgIndex.tcl         # package ifneeded naive_sort 1.0
    ├── test/
    │   └── naive_sort.test      # 3 algoritmos × 7 casos
    └── README.md
```

---

## 🛠️ Patrón común / Common Pattern

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | Tcl 9.0.4 (`tclsh9.0`), instalado por usuario en `$HOME/.local/tcl-9.0.4` |
| **CLI** | `TCLLIBPATH="$(cd ../src && pwd)" tclsh9.0 <suite>.test`, desde `test/` |
| **Andamiaje** | ✍️ Estructura manual (`mkdir -p src test`), la que ya usan [`foundations/numbers/`](../foundations/numbers/) y `foundations/unit_test/calculator/` |
| **Framework de tests** | Tcltest 2.5.11, incluido en la distribución (`package require tcltest`) |
| **Runner** | La propia suite con `cleanupTests` imprime el resumen final; no hay `run_tests.tcl` |
| **Separación** | `src/` (paquete) ↔ `test/` (suites `.test`) |
| **Módulo fuente** | Un `namespace eval <Namespace>` con `namespace export` y `proc`s, más `package provide` al final, como `Numbers` y `Calculator` |
| **API** | Una función por algoritmo: `NaiveSort::selection_sort $lista`, etc. |
| **Naming** | `snake_case` idéntico al de la especificación (`selection_sort`), como en los otros módulos Tcl del repositorio |
| **Semántica de valor** | Las listas son valores: los algoritmos ordenan una copia local (`set result $array`) y devuelven una lista nueva; los fixtures no se contaminan |
| **Nulabilidad** | Tcl no tiene `null`/`nil` y `{}` es la lista vacía y la cadena vacía: el caso nulo no es representable y se omite |
| **Mensajes de aserción** | `test <nombre> "{algorithm} should sort {caso}" -body … -result …`, con el mensaje del contrato como descripción |
| **Verificación estática** | No hay compilador ni analizador estático: la comprobación es cargar el paquete (`package require naive_sort 1.0`) y ejecutar la suite |
| **Artefactos** | `*.log` (logs de Tcltest) — ignorados por el `.gitignore` del módulo |
| **Particularidades** | Los intercambios usan `lset` sobre la copia local (leyendo antes el valor a sobrescribir); los bucles son `for {set i 0} {$i < $n - 1} {incr i}` con índices 0-based; el paquete se localiza con `TCLLIBPATH` apuntando a `src/` |

---

## 🚀 Compilación rápida / Quick Build

```bash
# Naive Sort Tests
cd naive_sort/test
TCLLIBPATH="$(cd ../src && pwd)" tclsh9.0 naive_sort.test
```

---

## ▶️ Siguiente / Next

👉 Continúa con los módulos pendientes de esta fase en el [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).

👉 Continue with the pending modules of this phase in the [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).

---

*[← Volver a Core](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
