<b>For the local podman installation

Automatic rebuild and reload config required on each config file.


Open terminal and simply run the command below.

```
curl -sL https://raw.githubusercontent.com/U061/OU-TM352-Add-Config/refs/heads/main/add-config.sh | bash
```

The script will automate below task.</b>

Running on Microsoft Windows<br>

When running the VCE with Podman Desktop on Windows, the Vite development framework used in many of the activities will not automatically rebuild and reload. In order to make the rebuild functionality work, you need to update the vite.config.ts file in every activity you work on.

At the end of the file you will see a block that looks like this (in the React activities it will say plugins: [react()],):

```// https://vitejs.dev/config/
export default defineConfig({
  plugins: [svelte()],
  base: base,
})
```
Into this block, after the line base: base, you need to add the following code:

```server: {
  watch: {
    usePolling: true,
    interval: 1000
  },
},
```
The result will look like this (in the React activities it will say plugins: [react()],):

```// https://vitejs.dev/config/
export default defineConfig({
  plugins: [svelte()],
  base: base,
  server: {
    watch: {
      usePolling: true,
      interval: 1000
    },
  },
})
```
This will make the automatic rebuilding work (Vite will check once a second for any changes). However, you will have to manually reload the page after the rebuild.
