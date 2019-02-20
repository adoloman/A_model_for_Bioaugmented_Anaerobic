## Disclaimer
This instruction has been tested with:
- Windows 10 [x64]
- JDK 8.201 [x64]
- IntelliJ IDEA Community Edition 2018.3.4 [x64]
- Github Desktop

# 1. Preparation

## 1.1. Clone this repository
Use some short name and place the folder in a the root of your disk drive.
Example: ```C:\iDynoMICs```.
In case of using [Github Desktop](https://desktop.github.com/) you can do it in following way:

Open Github Desktop:
![github_empty](instructions_images/import_from_github/00._github_empty.png)
And press "Clone repository from the internet". You will receive the following window :
![github_account](instructions_images/import_from_github/01._github_account.png)
Where you need to switch to "URL" tab:
![github_url](instructions_images/import_from_github/02._github_url.png)
Enter the url of [this repository](https://github.com/adoloman/Modified-iDynoMICs-for-augmentation-model):
![github_entered](instructions_images/import_from_github/03._github_entered.png)
To avoid any potential problems with path length limit in your OS, it would be reasonable to use short folder name like ```iDynoMICs``` and place the cloned repository to the root of disk. In scope of this example the repository was placed into ```C:\iDynoMICs```:
![github_path_fixed](instructions_images/import_from_github/04._github_path_fixed.png)
Wait till Github Desktop finish copying:
![github_imported](instructions_images/import_from_github/05._github_imported.png)
Done!

## 1.2. Install the Java SDK
Download and install [Java SDK 8](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

## 1.3. Install the IntelliJ IDEA
Download and install [IntelliJ IDEA](https://www.jetbrains.com/idea/download/)

# 2. Setting Up

## 2.1. Open the project in IDE

Launch the IntelliJ IDEA and you will see the initial screen:
![start_window](instructions_images/project_import/00._main_window.png)
Press ```Create New Project``` and choose ```Empty Project``` in popped up dialog:
![new_project_window](instructions_images/project_import/01._create_empty_project.png)
Click ```Next```. Now you will see the window for selecting folder of project:
![select_project_folder](instructions_images/project_import/02._select_location.png)
Press the ```...``` button nearby field ```Project location:``` and navigate to the folder, where you did clone the repository. In scope of this example it is ```C:\iDynoMICs```:
![selecting_project_folder](instructions_images/project_import/03._selecting_location.png)
Press ```OK``` and you will be returned to previous dialog:
![selected_folder](instructions_images/project_import/04._location_selected.png)
Now click ```Finish```.

## 2.2. Configure the project structure
Right after finishing step 2.1 the following dialog will appear:
![imported_project](instructions_images/project_import/05._freshly_opened_project.png)
Click ```+``` button and select ```Import Module```:
![import_modules](instructions_images/project_import/06._import_module.png)

Now add 2 modules from repository which are located at:
- ```'repository_root_folder'/cDynomics_Amitesh.iml```
- ```'repository_root_folder'/RemoteSystemsTempFiles\RemoteSystemsTempFiles.iml```
In scope of this example they are:
- ```C:\iDynoMICs\cDynomics_Amitesh.iml```
- ```C:\iDynoMICs\RemoteSystemsTempFiles\RemoteSystemsTempFiles.iml```

Now the dialog window should looks like this:
![modules_imported](instructions_images/project_import/07._modules_imported.png)

Do _**NOT**_ close dialog, but switch to ```Project Settings``` ->  ```Project```:
![project_settings](instructions_images/project_import/08._project_settings.png)
Now select the Java SDK with belongs to JAVA 8:
![select_SDK](instructions_images/project_import/09._select_JDK.png)
and change the ```Project language level``` to ```8 - Lambdas, type annotations etc.```:
![select_project_level](instructions_images/project_import/10._select_project_language_level.png)
Click ```OK```.
Now it should return you to a main windows of project:
![add_congiguration](instructions_images/project_import/11._add_configuration.png)

## 2.3. Configure the main class of project
Go to ```Run``` -> ```Edit configurations...```:
![edit_congiguration](instructions_images/project_import/12.1._edit_configuration.png)
You will see the following window:
![main_configuration](instructions_images/project_import/12.2._configuration_main_window.png)
Click ```+``` and select ```Application```:
![add_application](instructions_images/project_import/12._add_application.png)
You will receive the following dialog window:
![application_added](instructions_images/project_import/13._added_new_application.png)
Now add JRE (Java Runtime Environment), which belongs to Java SDK 8:
![add_JRE](instructions_images/project_import/14._add_JRE.png)
and select ```cDynomicas_Amitesh``` as classpath of module:
![add_classpath_of_module](instructions_images/project_import/15._add_classpath_of_module.png)
Click the ```...``` button to the right from Main Class field and you will be forwarded to dialog to chose the main class:
![choose_class_by_name](instructions_images/project_import/16._choose_main_class_by_name.png)
Switch to ```Project``` tab:
![choose_class_in_project](instructions_images/project_import/17._choose_main_class_in_project.png)
and navigate to file located  at ```'iDynoMICs_root_folder'/src/idyno/Idynomics.java```
_**NB!** In selection window the file may be shown without extensions._
In scope of this example it is ```C:\iDynoMICs\src\idyno\Idynomics.java``` :
![chosen_main_class](instructions_images/project_import/18._chosen_main_class.png)
Click ```OK``` and you will be returned to ```Run/Debug Configurations``` dialog.
Just for convenience change the ```Name``` from ```Unnamed``` to ```Idynomics```:
![configured](instructions_images/project_import/19._configured.png)
Now press ```OK``` and you will be returned to main project window:
![ready_to_run](instructions_images/project_import/20._ready_to_run.png)
## 2.4. [Optional] Run test simulation
This repository provides the sample of protocol, which can be used for testing the setup.
Simply run the project via ```Run``` ->  ```Run 'Idynomics'```:
![run_test](instructions_images/project_import/21._run_test.png)


# 3. Configure simulation
## 3.1. Get the protocol of simulation
Write or copy existing protocol as .xml-file to folder ```protocols``` of main iDynoMICs folder.

## 3.2. Specify your protocol location for simulation
Open file ```Constants.java``` located in ```'iDynoMICs_root_folder'/src/SearchEngine/Constants.java``` and edit values of variables:
- ```OUTPUT_PATH``` : ```'iDynoMICs_root_folder'\\results\\Out.txt```
- ```RESULT_PATH``` : ```'iDynoMICs_root_folder'\\results```
- ```XML_PATH``` : ```'iDynoMICs_root_folder'\\protocols\\'your_protocol_name'.xml```

In scope of this example the location is: ```C:\iDynoMICs\src\SearchEngine\Constants.java``` and variables are assigned as:
- ```OUTPUT_PATH``` : ```C:\\iDynoMICs\\results\\Out.txt```
- ```RESULT_PATH``` : ```C:\\iDynoMICs\\results```
- ```XML_PATH``` : ```C:\\iDynoMICs\\protocols\\test_protocol.xml```

Save your changes.

## 3.3. Run simulation
You can now run simulation with one of following ways:
1. Press ```Shift```+```F10```
2. Go to ```Run``` -> ```Run Idynomics```
![run_test](instructions_images/project_import/21._run_test.png)
3. Hit the ```Run``` button:
![launch](instructions_images/Launch_simulation.PNG)
