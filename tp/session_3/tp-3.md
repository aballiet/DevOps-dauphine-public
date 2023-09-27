# TP 3

## Partie 0: (si TP précédent pas terminé) Reprendre les partie 3 et 4 du TP 2

- https://cloud.google.com/build/docs/deploy-containerized-application-cloud-run?hl=fr

- https://cloud.google.com/build/docs/automate-builds?hl=fr


## Partie 1 : Infrastructure as Code

###  Gérer une Infrastructure as Code avec Terraform, Cloud Build et GitOps

https://cloud.google.com/docs/terraform/resource-management/managing-infrastructure-as-code?hl=fr

## Partie 2 : CLoud Provider

### Les services managés

- Lister les principaux services managés de base de données de GCP
- Comparer leur cas d'usage : prix (utiliser le calculateur pour vous faire une idée), type de base de données, garanties, scaling

> Le but ici est que vous puissiez vous faire une idée des prix suivant les cas d'usages et de la diversité des solutions proposées.

### Trouver la documentation **terraform** associée aux services que vous connaissez

- APIs activés
- Artifact Registry
- Cloud Run

- Comprendre leur définition
- Comparer avec la documentation du service

### Utiliser terraform et cloud build pour déployer une application

Reprendre le code de l'application Node utilisée dans le TP 1.

- App.js :

```js
cat > app.js <<EOF
const http = require('http');
const hostname = '0.0.0.0';
const port = 80;
const server = http.createServer((req, res) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end('Hello World\n');
});
server.listen(port, hostname, () => {
    console.log('Server running at http://%s:%s/', hostname, port);
});
process.on('SIGINT', function() {
    console.log('Caught interrupt signal and will exit');
    process.exit();
});
```

- Dockerfile

```dockerfile
# Use an official Node runtime as the parent image
FROM node:lts
# Set the working directory in the container to /app
WORKDIR /app
# Copy the current directory contents into the container at /app
ADD . /app
# Make the container's port 80 available to the outside world
EXPOSE 80
# Run app.js using node when the container launches
CMD ["node", "app.js"]
```

Votre code terraform doit :
-> Activer les APIs nécessaires sur votre projet
-> Créer le repo Artifact Registry

Votre pipeline Cloud Build doit :
-> Appliquer les changements de votre code terraform sur votre projet
-> Build et push l'image docker sur une repo Artifact Registry

Bonus : déployer l'image docker sur une instance cloud run définie en code terraform