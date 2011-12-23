# Define language variant for the installer 
LoadLanguageFile "${NSISDIR}\Contrib\Language files\French.nlf"
LicenseLangString LicenseData ${LANG_FRENCH} "doc\fr\License.txt"
VIAddVersionKey /LANG=${LANG_FRENCH} "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey /LANG=${LANG_FRENCH} "Comments" "Programmeur PIC"
VIAddVersionKey /LANG=${LANG_FRENCH} "LegalCopyright" "� Philippe Chevrier et Contributeurs"
VIAddVersionKey /LANG=${LANG_FRENCH} "FileDescription" "Programmeur PIC"
VIAddVersionKey /LANG=${LANG_FRENCH} "FileVersion" "${VERSION_TEXT}"

LangString Win9xError /LANG=${LANG_FRENCH} "Cet installeur ne fonctionne pas sous Windows 9x !"
LangString LangSectionName /LANG=${LANG_FRENCH} "Langues"
LangString ShortCutSectionName /LANG=${LANG_FRENCH} "Raccourci dans le menu D�marrer"
LangString DeviceFilesExist /LANG=${LANG_FRENCH} "Voulez-vous conserver les fichiers du r�pertoire Devices ?"
LangString CantDeleteExe /LANG=${LANG_FRENCH} "${EXE_NAME} ne peut pas �tre supprim�. Il est peut-�tre en cours d'ex�cution. Arr�tez-le et r�-essayez."
LangString UninstallWarning /LANG=${LANG_FRENCH} "Ceci va d�sinstaller ${EXE_NAME}. Cliquez D�sinstaller pour continuer."
LangString WinRingSectionName32 /LANG=${LANG_FRENCH} "Driver WingRing0 32 bits"
LangString WinRingSectionName64 /LANG=${LANG_FRENCH} "Driver WingRing0 64 bits"
LangString DeviceDirReadme /LANG=${LANG_FRENCH} "Les fichiers de d�finition de composant (*.dev) sont recherch�s dans ce r�pertoire. Vous pouvez copier les fichiers de composant de MPLAB ici."
