# Calculator — Tcl/Tk

Implementación de la especificación [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) en **Tcl/Tk**, usando una estructura tipo librería con `src/` y `test/`, y **Tcltest** como framework de pruebas unitarias incluido en la distribución de Tcl.

Tk no es necesario para este módulo porque no se crea una interfaz gráfica.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`src/calculator.tcl`](src/calculator.tcl) | Implementación del paquete `calculator` y namespace `Calculator`. |
| [`src/pkgIndex.tcl`](src/pkgIndex.tcl) | Registro del paquete para `package require calculator 1.0`. |
| [`test/calculator.test`](test/calculator.test) | Suite Tcltest con cinco casos agrupados por operación. |
| [`.gitignore`](.gitignore) | Ignora logs locales de ejecución. |

```text
calculator/
├── src/
│   ├── calculator.tcl
│   └── pkgIndex.tcl
├── test/
│   └── calculator.test
├── .gitignore
└── README.md
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente como una librería Tcl. `src/calculator.tcl` define el namespace `Calculator` y publica el paquete con `package provide`; `src/pkgIndex.tcl` permite localizarlo mediante `package require`. La suite usa Tcltest y no necesita dependencias externas.

**EN:** The project was created manually as a Tcl library. `src/calculator.tcl` defines the `Calculator` namespace and publishes the package with `package provide`; `src/pkgIndex.tcl` lets Tcl locate it through `package require`. The suite uses Tcltest and needs no external dependencies.

Las operaciones siguen las implementaciones educativas de la especificación:

- `addition`: suma directa.
- `subtraction`: resta directa.
- `multiplication`: suma repetitiva, sin usar `*`.
- `division`: resta repetitiva, sin usar `/`.
- `modulus`: reutiliza `division` y `multiplication`, sin usar `%`.

### Inicialización / Initialization

```bash
mkdir -p tcl-tk/core/foundations/unit_test/calculator/{src,test}
cd tcl-tk/core/foundations/unit_test/calculator
```

Después se escriben el paquete en `src/` y la suite Tcltest en `test/`.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `src/pkgIndex.tcl`

```tcl
package ifneeded calculator 1.0 [list source [file join $dir calculator.tcl]]
```

`pkgIndex.tcl` registra cómo cargar el paquete cuando Tcl recibe `package require calculator 1.0`.

### `test/calculator.test`

La suite usa `package require tcltest`, registra un test por operación y agrupa los cinco casos por nombre de método. `cleanupTests` imprime el resumen y devuelve un estado apropiado al proceso.

---

## 🚀 Ejecución / Run

### Requisitos / Requirements

- **Tcl 9.0.4**.
- **Tcltest 2.5.11**, incluido con la instalación de Tcl.

Verificar el entorno:

```bash
tclsh9.0 <<< 'puts [info patchlevel]'
tclsh9.0 <<< 'puts [package require tcltest]'
```

Salida verificada:

```text
9.0.4
2.5.11
```

### Ejecutar las pruebas / Run tests

```bash
cd tcl-tk/core/foundations/unit_test/calculator/test
TCLLIBPATH="$(cd ../src && pwd)" tclsh9.0 calculator.test
```

### Salida esperada / Expected output

```text
calculator addition-1 PASSED
calculator subtraction-1 PASSED
calculator multiplication-1 PASSED
calculator division-1 PASSED
calculator modulus-1 PASSED

Tests ended at ...
all.tcl: Total 5 Passed 5 Failed 0
```

> **ES:** El formato exacto puede variar entre versiones de Tcltest, pero deben pasar los 5 tests y producirse 0 fallos.
> **EN:** The exact format may vary across Tcltest versions, but all 5 tests must pass with 0 failures.

---

## 🧠 Operaciones / Operations

| Operación | Implementación educativa |
|-----------|--------------------------|
| `addition(a, b)` | Suma directa (`expr {$a + $b}`). |
| `subtraction(a, b)` | Resta directa (`expr {$a - $b}`). |
| `multiplication(a, b)` | Suma `a` repetidamente mediante `for`. |
| `division(a, b)` | Resta `b` repetidamente mediante `while`. |
| `modulus(a, b)` | Calcula el resto reutilizando `division` y `multiplication`. |

Los cinco casos están agrupados por operación dentro de la suite Tcltest.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Tcltest proporciona el runner, las aserciones y el reporte; por eso no se crea un `run_tests.tcl` separado.
- **EN:** Tcltest provides the runner, assertions, and report, so no separate `run_tests.tcl` file is created.
- **ES:** El paquete se carga mediante `TCLLIBPATH`, manteniendo separado el código de `src/` y las pruebas de `test/`.
- **EN:** The package is loaded through `TCLLIBPATH`, keeping `src/` code separate from tests under `test/`.
- **ES:** La división por cero y los divisores no positivos quedan fuera de los casos básicos y generan un error explícito.
- **EN:** Division by zero and non-positive divisors are outside the basic cases and produce an explicit error.
- **ES:** El código fuente no incluye comentarios inline; la explicación se mantiene en este README.
- **EN:** The source code contains no inline comments; explanations are kept in this README.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
