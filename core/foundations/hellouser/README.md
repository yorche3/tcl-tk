# Hello, User! — Tcl/Tk

Implementación de la especificación [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) en **Tcl/Tk**, con un enfoque manual y minimalista.

Solicita un nombre mediante la entrada estándar y muestra un saludo personalizado. Tk no es necesario porque el ejemplo no crea una interfaz gráfica.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`hello_user.tcl`](hello_user.tcl) | Código fuente: muestra un prompt, lee un nombre y escribe un saludo. |

**Estructura de directorios esperada:**

```text
hellouser/
├── hello_user.tcl  # Código fuente
└── README.md       # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente, sin Tcl packages ni herramientas de scaffolding. El archivo usa los comandos estándar `puts`, `flush`, `set` y `gets` para interactuar con la entrada y salida estándar.

**EN:** The project was created manually, without Tcl packages or scaffolding tools. The file uses the standard `puts`, `flush`, `set`, and `gets` commands to interact with standard input and output.

El flujo del programa es:

1. Mostrar el prompt sin salto de línea.
2. Vaciar `stdout` para que el prompt aparezca inmediatamente.
3. Leer una línea desde `stdin`.
4. Interpolar el nombre en el saludo.
5. Mostrar el saludo con un salto de línea.

The program flow is:

1. Display the prompt without a newline.
2. Flush `stdout` so the prompt appears immediately.
3. Read one line from `stdin`.
4. Interpolate the name into the greeting.
5. Print the greeting with a newline.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p tcl-tk/core/foundations/hellouser
   ```

2. Escribir el archivo `hello_user.tcl` con el código fuente.

3. Ejecutarlo con `tclsh9.0`.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración para este ejercicio. El script utiliza únicamente comandos estándar de Tcl.

```tcl
puts -nonewline "Please enter your name: "
flush stdout
set name [gets stdin]
puts "Hello, $name!"
```

| Elemento | Propósito |
|----------|-----------|
| `puts -nonewline` | Escribe el prompt sin añadir un salto de línea. |
| `flush stdout` | Fuerza la escritura inmediata del prompt. |
| `gets stdin` | Lee una línea desde la entrada estándar. |
| `set name ...` | Guarda el nombre leído en la variable `name`. |
| `puts "Hello, $name!"` | Interpola `name` y muestra el saludo con salto de línea. |

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

### Ejecutar de forma interactiva / Run interactively

```bash
cd tcl-tk/core/foundations/hellouser
tclsh9.0 hello_user.tcl
```

El programa muestra el prompt, espera el nombre y después imprime el saludo.

The program displays the prompt, waits for the name, and then prints the greeting.

### Ejecutar con entrada redirigida / Run with redirected input

```bash
cd tcl-tk/core/foundations/hellouser
printf 'Ada\n' | tclsh9.0 hello_user.tcl
```

### Salida esperada / Expected output

Con la entrada `Ada`, la salida verificada es:

```text
Please enter your name: Hello, Ada!
```

El prompt y la entrada aparecen en la misma línea porque `puts -nonewline` no añade un salto de línea. El saludo aparece en la misma línea en una ejecución con entrada redirigida, y `puts` añade el salto de línea final.

The prompt and input appear on the same line because `puts -nonewline` does not append a newline. The greeting remains on that line for redirected input, and `puts` adds the final newline.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Tcl no requiere una función `main`; el intérprete evalúa el script en el orden en que aparecen sus comandos.
- **EN:** Tcl does not require a `main` function; the interpreter evaluates the script in command order.
- **ES:** `flush stdout` es importante en una ejecución interactiva para que el prompt se muestre antes de esperar la entrada.
- **EN:** `flush stdout` is important for interactive execution so the prompt appears before waiting for input.
- **ES:** El script no usa Tk ni genera artefactos de compilación persistentes.
- **EN:** The script does not use Tk or generate persistent build artifacts.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
