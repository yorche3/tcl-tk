# 🚀 Fundamentos / Foundations — Tcl/Tk

Implementación de los ejercicios de la sección [Fundamentos / Foundations](https://yorche3.github.io/programming_languages/core/foundations/) del repositorio principal en **Tcl/Tk**.

Los ejercicios exploran Tcl mediante scripts independientes y proyectos tipo librería probados con **Tcltest**. Tk no se utiliza todavía porque los módulos actuales no crean interfaces gráficas.

---

## 📖 Descripción / Description

**ES:** Esta sección reúne los conceptos esenciales para empezar a trabajar con Tcl. Comienza con scripts de salida y entrada estándar, continúa con una librería aritmética y termina con algoritmos numéricos en tres enfoques.

**EN:** This section brings together the essential concepts for getting started with Tcl. It begins with output and standard-input scripts, continues with an arithmetic library, and ends with numerical algorithms in three approaches.

---

## 📁 Estructura / Structure

```text
tcl-tk/
└── core/
    └── foundations/
        ├── README.md                   # Este archivo / This file
        ├── helloworld/                 # 01_Hello_World
        │   ├── hello_world.tcl
        │   └── README.md
        ├── hellouser/                  # 02_Hello_User
        │   ├── hello_user.tcl
        │   └── README.md
        ├── unit_test/
        │   └── calculator/             # 03_Unit_Test_Calculator
        │       ├── src/
        │       │   ├── calculator.tcl
        │       │   └── pkgIndex.tcl
        │       ├── test/
        │       │   └── calculator.test
        │       ├── .gitignore
        │       └── README.md
        └── numbers/                    # 04_Numbers
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

## 🔢 Progresión / Progression

| Especificación | Proyecto | Conceptos | Tests | Dependencias |
| -------------- | -------- | --------- | :---: | ------------ |
| [`01_Hello_World`](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) | [`helloworld/`](helloworld/) | `puts`, scripts Tcl, salida estándar | — | Solo Tcl |
| [`02_Hello_User`](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) | [`hellouser/`](hellouser/) | `gets`, `stdin`, `flush`, interpolación | — | Solo Tcl |
| [`03_Unit_Test_Calculator`](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) | [`unit_test/calculator/`](unit_test/calculator/) | paquetes Tcl, namespaces, `pkgIndex.tcl`, Tcltest | 5 | Tcltest incluido |
| [`04_Numbers`](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) | [`numbers/`](numbers/) | recursión, acumuladores, `for`, `while`, TCO | 10 (22 casos) | Tcltest incluido |

---

## 🛠️ Enfoque general / General Approach

**ES:** Los proyectos de esta sección siguen una progresión gradual:

1. **Hello World**: script Tcl independiente que usa `puts` para imprimir un saludo.
2. **Hello User**: script que usa `puts -nonewline`, `flush` y `gets stdin` para interactuar con el usuario.
3. **Calculator**: primer proyecto tipo librería. Separa `src/` y `test/`, registra un paquete mediante `pkgIndex.tcl` y usa Tcltest para las cinco operaciones educativas.
4. **Numbers**: implementa cinco algoritmos en tres enfoques. Tcl tiene `for`/`while`, pero no ofrece una garantía general de TCO; por eso se prueban `_rec` e `_ite`, mientras `_acc` se conserva como puente didáctico sin suite propia.

**EN:** The projects in this section follow a gradual progression:

1. **Hello World**: standalone Tcl script using `puts` to print a greeting.
2. **Hello User**: script using `puts -nonewline`, `flush`, and `gets stdin` to interact with the user.
3. **Calculator**: the first library-style project. It separates `src/` and `test/`, registers a package through `pkgIndex.tcl`, and uses Tcltest for the five educational operations.
4. **Numbers**: implements five algorithms in three approaches. Tcl has `for`/`while`, but does not provide a general TCO guarantee; therefore `_rec` and `_ite` are tested, while `_acc` remains an educational bridge without its own suite.

---

## 📦 Requisitos / Requirements

| Herramienta | Uso | Verificación |
| ----------- | --- | ------------ |
| Tcl 9.0.4 | Intérprete y lenguaje | `tclsh9.0 <<< 'puts [info patchlevel]'` |
| Tcltest 2.5.11 | Framework de pruebas | `tclsh9.0 <<< 'puts [package require tcltest]'` |
| Tk | Interfaces gráficas futuras | No requerido por estos módulos |

En este entorno Tcl se instaló en `$HOME/.local/tcl-9.0.4` y su directorio `bin` se añadió al `PATH` desde `.bashrc`.

```bash
source "$HOME/.bashrc"
tclsh9.0 <<< 'puts [info patchlevel]'
tclsh9.0 <<< 'puts [package require tcltest]'
```

---

## 🚀 Ejecución rápida / Quick Start

### Hello World

```bash
cd tcl-tk/core/foundations/helloworld
tclsh9.0 hello_world.tcl
```

### Hello User

```bash
cd tcl-tk/core/foundations/hellouser
printf 'Ada\n' | tclsh9.0 hello_user.tcl
```

### Calculator

```bash
cd tcl-tk/core/foundations/unit_test/calculator/test
TCLLIBPATH="$(cd ../src && pwd)" tclsh9.0 calculator.test
```

Resultado verificado:

```text
Total 5 Passed 5 Failed 0
```

### Numbers

```bash
cd tcl-tk/core/foundations/numbers/test
TCLLIBPATH="$(cd ../src && pwd)" tclsh9.0 recursive.test
TCLLIBPATH="$(cd ../src && pwd)" tclsh9.0 iterative.test
```

Resultado verificado:

```text
Total 11 Passed 11 Failed 0
Total 11 Passed 11 Failed 0
```

---

## 🧪 Convenciones de pruebas / Testing Conventions

**ES:** Los proyectos tipo librería usan Tcltest, incluido en la distribución de Tcl. Las suites se mantienen en `test/` y cargan los paquetes de `src/` mediante `TCLLIBPATH`. Cada suite agrupa los casos por algoritmo.

**EN:** Library-style projects use Tcltest, included with the Tcl distribution. Suites live under `test/` and load packages from `src/` through `TCLLIBPATH`. Each suite groups cases by algorithm.

`calculator` tiene 5 tests. `numbers` tiene 2 suites con 5 grupos de algoritmos y 22 casos/assertions en total.

`calculator` has 5 tests. `numbers` has 2 suites with 5 algorithm groups and 22 total cases/assertions.

---

## 🔁 TCO e iteración / TCO and Iteration

Tcl ofrece iteración nativa mediante `for` y `while`, pero no se documenta una garantía general de Tail Call Optimization para este proyecto. Según la regla de `04_Numbers`, la combinación aplicada es:

Tcl provides native iteration through `for` and `while`, but no general Tail Call Optimization guarantee is documented for this project. According to the `04_Numbers` rule, the applied combination is:

```text
TCO no garantizada + iteración nativa ✅
_rec + _ite
2 suites
10 tests
22 casos
```

La implementación `_acc` permanece en el paquete como puente conceptual hacia `_ite`, pero no tiene una suite independiente.

The `_acc` implementation remains in the package as a conceptual bridge toward `_ite`, but it has no independent suite.

---

## 🧹 Artefactos de ejecución / Runtime Artifacts

Tcltest puede generar logs durante las pruebas. Los `.gitignore` locales excluyen esos archivos para que no se versionen. Los scripts Tcl independientes no generan artefactos de compilación persistentes.

Tcltest may generate logs during testing. Local `.gitignore` files exclude those files so they are not versioned. Standalone Tcl scripts do not generate persistent build artifacts.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
