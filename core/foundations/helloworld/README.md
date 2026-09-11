# Hello, World! — Tcl/Tk

Implementación de la especificación [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) en **Tcl/Tk**, con un enfoque manual y minimalista.

Este ejercicio utiliza Tcl para imprimir un saludo en la salida estándar. Tk no es necesario porque el ejemplo no crea una interfaz gráfica.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`hello_world.tcl`](hello_world.tcl) | Código fuente: imprime `"Hello, World! from TCL/TK"`. |

**Estructura de directorios esperada:**

```text
helloworld/
├── hello_world.tcl  # Código fuente
└── README.md        # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente, sin Tcl packages ni herramientas de scaffolding. Un único archivo `.tcl` es suficiente porque Tcl es un lenguaje interpretado y puede ejecutarse directamente con `tclsh`.

**EN:** The project was created manually, without Tcl packages or scaffolding tools. A single `.tcl` file is enough because Tcl is interpreted and can run directly with `tclsh`.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p tcl-tk/core/foundations/helloworld
   ```

2. Escribir el archivo `hello_world.tcl` con el código fuente.

3. Ejecutarlo con `tclsh`.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración para este ejercicio. El script usa únicamente el comando estándar `puts` de Tcl.

```tcl
puts "Hello, World! from TCL/TK"
```

| Elemento | Propósito |
|----------|-----------|
| `puts` | Escribe texto en la salida estándar y añade un salto de línea. |
| `"Hello, World! from TCL/TK"` | Cadena que se muestra al usuario. |

> **ES:** El programa no utiliza Tk porque no necesita ventanas ni widgets; `tclsh` es suficiente para ejecutar este script Tcl.
> **EN:** The program does not use Tk because it needs no windows or widgets; `tclsh` is sufficient to run this Tcl script.

---

## 🚀 Ejecución / Run

### Requisitos / Requirements

- **Tcl 9.0.4**.
- `tclsh9.0`, el intérprete de Tcl.

Verificar la instalación:

```bash
tclsh9.0 <<< 'puts [info patchlevel]'
```

Salida verificada:

```text
9.0.4
```

En este entorno, Tcl se instaló en `$HOME/.local/tcl-9.0.4` y su directorio `bin` se añadió al `PATH` desde `.bashrc`.

In this environment, Tcl was installed under `$HOME/.local/tcl-9.0.4`, and its `bin` directory was added to `PATH` through `.bashrc`.

### Ejecutar el script / Run the script

```bash
cd tcl-tk/core/foundations/helloworld
tclsh9.0 hello_world.tcl
```

También puede usarse `tclsh` si apunta a la instalación Tcl 9.0.4:

```bash
tclsh hello_world.tcl
```

### Salida esperada / Expected output

```text
Hello, World! from TCL/TK
```

La salida fue verificada con Tcl 9.0.4 en WSL2.

The output was verified with Tcl 9.0.4 on WSL2.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Tcl no requiere una función `main`; el intérprete evalúa el script en el orden en que aparecen sus comandos.
- **EN:** Tcl does not require a `main` function; the interpreter evaluates the script in command order.
- **ES:** `puts` añade un salto de línea automáticamente.
- **EN:** `puts` automatically appends a newline.
- **ES:** El script no genera artefactos de compilación persistentes.
- **EN:** The script does not generate persistent build artifacts.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
