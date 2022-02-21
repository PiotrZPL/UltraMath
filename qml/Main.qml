/*
 * Copyright (C) 2022 Piotr Lange
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * UltraMath is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import io.thp.pyotherside 1.3
import "./"

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'ultramath.piotrzpl'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    property string app_version: "0.0.1"

    
    property var settings: Settings {
        property string primaryColor: "#0169c9"
        property string theme: "Ambiance"
        onThemeChanged: Theme.name = "Ubuntu.Components.Themes." + settings.theme
    }

    Component {
        id: aboutPage
        About {}
    }
    
    PageStack{
        id: pageStack

        Component.onCompleted: push(mainPage)

	    Page {
	        id: mainPage
	        visible: false
	        anchors.fill: parent
	
	        header: PageHeader {
	            id: header
	            title: i18n.tr('UltraMath')
	            trailingActionBar.actions: [
	                    Action {
	                        text: i18n.tr("Theme")
	                        iconName: (root.settings.theme == "Ambiance") ? "torch-on" : "torch-off"
	                        onTriggered: root.settings.theme = (root.settings.theme == "Ambiance") ? "SuruDark" : "Ambiance"
	                    },
	                    Action {
	                        text: i18n.tr("About")
	                        iconName: "help"
	                        onTriggered: pageStack.push(aboutPage)
	                    }
	                ]
	        }
	
	        Grid {
	            anchors { 
	                top: header.bottom
	                left: parent.left
	                right: parent.right
	                bottom: parent.bottom
	            }
	            columns: 3
	            rows: 3
	            
				MainButton {
	                    text: i18n.tr("Binary number calculator")
	                    color: "#f95959"
	                    color_text : (root.settings.theme == "Ambiance") ? "black" : "white"
	                    height: parent.height / parent.rows
	                    width: parent.width / parent.columns
	                    onClicked: {textField.text=textField.text.substr(0, textField.text.length-1);
	                    }
	            }
				MainButton {
	                    text: i18n.tr("Prime number check")
	                    color: "#006f6c"
	                    color_text : (root.settings.theme == "Ambiance") ? "black" : "white"
	                    height: parent.height / parent.rows
	                    width: parent.width / parent.columns
	                    onClicked: {textField.text=textField.text.substr(0, textField.text.length-1);
	                    }
	            }
				MainButton {
	                    text: i18n.tr("Graphing")
	                    color: "#c800ff"
	                    color_text : (root.settings.theme == "Ambiance") ? "black" : "white"
	                    height: parent.height / parent.rows
	                    width: parent.width / parent.columns
	                    onClicked: {textField.text=textField.text.substr(0, textField.text.length-1);
	                    }
	            }
				MainButton {
	                    text: i18n.tr("GCF calculator")
	                    color: "#2d00ff"
	                    color_text : (root.settings.theme == "Ambiance") ? "black" : "white"
	                    height: parent.height / parent.rows
	                    width: parent.width / parent.columns
	                    onClicked: {textField.text=textField.text.substr(0, textField.text.length-1);
	                    }
	            }
				MainButton {
	                    text: i18n.tr("LCM calculator")
	                    color: "#ff0009"
	                    color_text : (root.settings.theme == "Ambiance") ? "black" : "white"
	                    height: parent.height / parent.rows
	                    width: parent.width / parent.columns
	                    onClicked: {textField.text=textField.text.substr(0, textField.text.length-1);
	                    }
	            }
				MainButton {
	                    text: i18n.tr("Base converter")
	                    color: "#00ff72"
	                    color_text : (root.settings.theme == "Ambiance") ? "black" : "white"
	                    height: parent.height / parent.rows
	                    width: parent.width / parent.columns
	                    onClicked: {textField.text=textField.text.substr(0, textField.text.length-1);
	                    }
	            }
				MainButton {
	                    text: "←"
	                    color: "#5E2750"
	                    color_text : "white"
	                    height: parent.height / parent.rows
	                    width: parent.width / parent.columns
	                    onClicked: {textField.text=textField.text.substr(0, textField.text.length-1);
	                    }
	            }

				MainButton {
	                    text: "="
	                    color: "#5E2750"
	                    color_text : "white"
	                    height: parent.height / parent.rows
	                    width: parent.width / parent.columns
	                    onClicked: {
	                        python.call("example.calculate", [ textField.text ], function ( result ) {
	                        var isValid = result[0];
	                        if (isValid) {
	                        textField.hasError =false
	                        textField.text = result[1];
	                        } else {
	                        textField.hasError =true  
	                        }
	                    })
	                    }
				}
	            MainButton {
	                    text: "←"
	                    color: "#5E2750"
	                    color_text : "white"
	                    height: parent.height / parent.rows
	                    width: parent.width / parent.columns
	                    onClicked: {textField.text=textField.text.substr(0, textField.text.length-1);
	                    }
	            }
	        }
	
	        height: units.gu(8)
	        //font.pixelSize: units.gu(4)   
	        Python {
	            id: python
	
	            Component.onCompleted: {
	                addImportPath(Qt.resolvedUrl('../src/'));
	            importModule_sync("example")
	            }
	
	            onError: {
	                console.log('python error: ' + traceback);
	            }
	        }
	    }
	}
}