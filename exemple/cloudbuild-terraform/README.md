# Pipeline CloudBuild pour automatiser le déploiement de ressources avec Terraform sur GCP

Cet exemple permet de déployer sur un projet GCP les ressources suivantes :
- `google_project_service` => Les APIs Google nécessaire à l'utilisation des resources
- `google_artifact_registry_repository` => dépôt docker permettant de stocker des images (comme DockerHub)

## Debug en case de problème

### PERMISSION_DENIED, rôles manquants dans CloudBuild

[Comme pour le TP3](https://cloud.google.com/docs/terraform/resource-management/managing-infrastructure-as-code?hl=fr#granting_permissions_to_your_cloud_build_service_account), nous devons donner les droits à CloudBuild de créer des ressources sur notre projet Google.
En effet, par défault CloudBuild n'a pas les autorisation pour faire les appels APIs nécessaires à la création de ressources.


Pour faire simple, on donne tous les droits à CloudBuild sur notre projet Google avec le rôle `roles/editor`

```bash
PROJECT_ID=$(gcloud config get-value project)
```


```bash
CLOUDBUILD_SA="$(gcloud projects describe $PROJECT_ID \
    --format 'value(projectNumber)')@cloudbuild.gserviceaccount.com"
```

```bash
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member serviceAccount:$CLOUDBUILD_SA --role roles/editor
```

### Erreur "Backend configuration changed"

![error_config_changed](images/error_backend_configuration_changed.png)


Attention, si vous utilisez directement la commande : `gcloud builds submit --config cloudbuild.yaml`, il faut veiller à ne pas envoyer le dossier `.terraform` ce qui peut perturber CloudBuild.

Afin de ne pas soumettre ce dossier, on définit le fichier `.gcloudignore` qui contient l'exclusion :

```bash
.terraform
```
