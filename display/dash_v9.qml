import QtQuick 2.0
import QtQuick.Window 2.1
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.4
//import QtQuick.Controls.Material 2.4
import QtQuick.Controls.Universal 2.0
import QtGraphicalEffects 1.0



ApplicationWindow {
    id: root
    color: mainBgColor
    visible: true
    width:1280
    height:800

    property color mainFontColor: "black"
    property color mainBgColor: "white"
    property color mainBgColorSub: "#eaeaea"
    property color mainAccentColor: "gray"
    property color rpmColor: "#4d6278"
    property int colorMode: 0
    property int rpm: 0
    property int speed: 0
    property int shiftLow: 11000
    property int shiftHigh: 12200

    onColorModeChanged: {
        if (colorMode=0) {
            mainFontColor = "black"
            mainBgColor = "white"
            mainBgColorSub = "eaeaea"
            baselayer.source = "images/dashMask_light.png"
            teamUpLabel.source = "images/triange_light.png"
            teamDnLabel.source = "images/triange_light.png"

        }

    }

    Timer {
        interval: 10
        running: true
        repeat: true
        onTriggered: {
            root.rpm = con.rpm()
            root.speed = con.speed()

            //positionNumber.text = con.raceTimeData('selfPosition')
            //lapNumber.text = con.raceTimeData('selfLaps')
            //lapTimeSelf.text = con.raceTimeData('selfLaptime')
            //positionNumber.text = '2'
            //lapNumber.text = '123'
            //lapTimeSelf.text = '0:49.431'


        }
    }

    Behavior on rpm {
        NumberAnimation { properties: "rpm"; duration: 1000 }

    }



    onRpmChanged: {
        // drive RPM animation
        if (rpm<6000) {
            rpmSweepMid.visible = false
            rpmSweepLow.height = rpm*220/6000
            rpmSweepHigh.visible = false
            rpmSweepOrange.visible = false
            rpmSweepRed.visible = false
        }

        if (rpm>6000 && rpm<7000) {
            rpmSweepLow.height = 220
            rpmSweepMid.visible = true
            rpmSweepMid.rotation = (rpm-6000)*9/100
            rpmSweepHigh.visible = false
            rpmSweepOrange.visible = false
            rpmSweepRed.visible = false
        }

        if (rpm>7000 && rpm <11000) {
            rpmSweepLow.height = 220
            rpmSweepHigh.visible = true
            rpmSweepMid.rotation = 90
            rpmSweepHigh.width = (rpm-7000)*99/600
            rpmSweepOrange.visible = false
            rpmSweepRed.visible = false
        }

        if (rpm>11000 && rpm<12000) {
            rpmSweepHigh.width = 660
            rpmSweepOrange.visible = true
            rpmSweepRed.visible = false
            rpmSweepOrange.width = (rpm-11000)*0.168
        }

        if (rpm>12000) {
            rpmSweepHigh.width = 660
            rpmSweepRed.visible = true
            rpmSweepRed.width = (rpm-12000)*.168
        }

        // set color and behavior of shift light
        var rpmGreen = parseInt(root.shiftGreen)
        var rpmYellow = parseInt(root.shiftYellow)
        var rpmRed = parseInt(root.shiftRed)
        var rpmFlash = parseInt(root.shiftRedFlash)

        //        if (rpm < rpmGreen) {rpmColor = "#4d6278"}  // out of powerband, blue RPM
        //        if (rpm < rpmYellow && rpm > rpmGreen) {rpmColor = "#00ff00"}  //start powerband, green
        //        if (rpm < rpmRed && rpm > rpmYellow) {rpmColor = "#ffff00"} //yellow
        //        if (rpm > rpmRed) {rpmColor = "#ff0000"} //red

        //adjust rpm font label size
        //        label0.font.pixelSize = (0 < root.rpm && root.rpm < 1000) ? 20 : 15

        //        speed.text = root.speed

    }
    onSpeedChanged: {
        speed.text = root.speed
    }

    Rectangle {
        id: rpmSweepLow
        y: 312
        width: 122
        height: 220
        color: root.rpmColor
        anchors.left: parent.left
        anchors.leftMargin: 37
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 288
        opacity: 1
        rotation: 0
        transformOrigin: Item.Top
    }


    Rectangle {
        id: rpmSweepMid
        x: -67
        y: 292
        width: 329
        height: 207
        color: root.rpmColor
        visible: true
        z: 0
        rotation: 90
        transformOrigin: Item.TopRight
    }


    Rectangle {
        id: rpmSweepHigh
        y: 9
        width: 990
        height: 145
        color: root.rpmColor
        anchors.left: parent.left
        anchors.leftMargin: 262
        transformOrigin: Item.Center
    }


    Rectangle {
        id: rpmSweepOrange
        x: 524
        y: 9
        width: 166
        height: 145
        color: "#ff9000"
        transformOrigin: Item.Center
        anchors.left: parent.left
        anchors.leftMargin: 916
    }


    Rectangle {
        id: rpmSweepRed
        x: 523
        y: 9
        width: 170
        height: 145
        color: "#ff0000"
        transformOrigin: Item.Center
        anchors.left: parent.left
        anchors.leftMargin: 1082
    }




    Image {
        id: baselayer
        source: "images/dashMask_light.png"
        x: 0
        y: 0
        width: 1280
        height: 800
        opacity: 1

        Text {
            id: speed
            x: 230
            y: 225
            text: qsTr("61")
            font.italic: true
            font.bold: true
            font.family: "Mont Heavy DEMO"
            font.pixelSize: 300

            Text {
                id: speedLabel
                x: 135
                y: 271
                text: qsTr("MPH")
                font.family: "BN Elements"
                font.pixelSize: 36
            }
        }


        Rectangle {
            id: tcSlipBg
            x: 396
            y: 825
            width: 80
            height: 65
            color: "#2b82dc"
            radius: 5
            visible: true
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: tempEngBg.verticalCenter
            Text {
                id: tcSlipDisp
                text: qsTr("5")
                visible: true
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 60
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: tcSlipLabel
                text: qsTr("SLIP")
                visible: true
                font.letterSpacing: 5
                font.italic: false
                anchors.rightMargin: 0
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 60
                anchors.right: parent.left
                font.family: "BN Elements"
            }
            border.width: 2
        }

        Rectangle {
            id: tcCutBg
            y: 714
            width: 80
            height: 80
            color: "#ffff00"
            radius: 5
            anchors.verticalCenterOffset: 146
            visible: true
            anchors.left: tcSlipBg.right
            anchors.leftMargin: -80
            anchors.verticalCenter: tcSlipBg.verticalCenter
            Text {
                id: tcCutDisp
                text: qsTr("3")
                visible: true
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 60
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: tcCutLabel
                text: qsTr("CUT")
                visible: true
                font.letterSpacing: 1
                anchors.rightMargin: 0
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 60
                anchors.right: parent.left
                font.family: "BN Elements"
            }
            border.width: 2
        }

        Text {
            id: teamMsg
            x: 8
            y: 538
            width: 545
            height: 101
            text: qsTr("TEAM MSG")
            font.family: "Mont Heavy DEMO"
            font.bold: false
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 95
        }

        Item {
            id: tempGroup
            x: 0
            y: 685
            width: 400
            height: 104

            Rectangle {
                id: tempEngBg
                y: 702
                width: 130
                height: 90
                color: "#00ff00"
                radius: 0
                anchors.left: parent.left
                anchors.leftMargin: 25
                anchors.verticalCenter: parent.verticalCenter
                border.width: 3

                Text {
                    id: tempEngDisp
                    text: qsTr("175")
                    anchors.horizontalCenterOffset: -10
                    font.bold: true
                    font.family: "Mont Heavy DEMO"
                    anchors.verticalCenterOffset: -10
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 60

                    Text {
                        id: tempDot
                        y: 35
                        text: qsTr("°")
                        anchors.left: parent.right
                        anchors.leftMargin: 0
                        font.bold: true
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 20
                        anchors.verticalCenterOffset: -12
                        font.family: "Arial"
                        rotation: 0

                        Text {
                            id: tempF
                            x: 95
                            y: 21
                            text: qsTr("F")
                            anchors.leftMargin: 0
                            anchors.verticalCenter: tempDot.verticalCenter
                            font.pixelSize: 20
                            anchors.left: parent.right
                            anchors.verticalCenterOffset: 0
                            font.family: "BN Elements"
                            rotation: 0
                        }
                    }

                }

                Text {
                    id: tempLabel
                    x: 3
                    y: 7
                    text: qsTr("T ENG")
                    font.family: "BN Elements"
                    font.pixelSize: 30
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenterOffset: 30
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Rectangle {
                id: tempAirBg
                x: -1
                y: 705
                width: 130
                height: 90
                radius: 0
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    id: tempAirDisp
                    text: qsTr("101")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 60
                    anchors.horizontalCenterOffset: -10
                    Text {
                        id: tempDot1
                        y: 35
                        text: qsTr("°")
                        anchors.leftMargin: 0
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 20
                        Text {
                            id: tempF1
                            x: 95
                            y: 21
                            text: qsTr("F")
                            anchors.leftMargin: 0
                            anchors.verticalCenter: tempDot1.verticalCenter
                            font.pixelSize: 20
                            anchors.left: parent.right
                            anchors.verticalCenterOffset: 0
                            font.family: "BN Elements"
                            rotation: 0
                        }
                        anchors.left: parent.right
                        anchors.verticalCenterOffset: -12
                        font.family: "Arial"
                        font.bold: true
                        rotation: 0
                    }
                    anchors.verticalCenterOffset: -10
                    font.bold: true
                    font.family: "Mont Heavy DEMO"
                }

                Text {
                    id: tempLabel1
                    x: 3
                    y: 7
                    text: qsTr("T AIR")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 30
                    anchors.verticalCenterOffset: 30
                    font.family: "BN Elements"
                }
                anchors.left: tempEngBg.right
                border.width: 3
            }
        }

        Rectangle {
            id: sesTBg
            width: 130
            height: 50
            color: "#00000000"
            radius: 0
            anchors.top: parent.top
            anchors.topMargin: 3
            Text {
                id: sesTDisp
                text: qsTr("15:45")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 50
                anchors.horizontalCenter: parent.horizontalCenter

            }

            Text {
                id: sesTlabel
                text: qsTr("RACE CLOCK")
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: parent.bottom
                anchors.topMargin: 1
                font.pixelSize: 15
                font.family: "BN Elements"
                color: root.mainAccentColor
            }
            anchors.leftMargin: 3
            anchors.left: parent.left
            border.width: 3
            border.color: root.mainAccentColor
        }
    }








    Item {
        id: pageHead
        x: 570
        y: 252
        width: 710
        height: 40


        Text {
            id: mainHead
            color: "#0000ff"
            text: qsTr("MAIN")
            styleColor: "#0000ff"
            anchors.verticalCenterOffset: 3
            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.verticalCenter: parent.verticalCenter
            font.family: "BN Elements"
            font.pixelSize: 28
        }
        Rectangle {
            id: selection
            x: mainHead.x
            y: mainHead.y
            width: mainHead.width+20
            height: 30
            color: "#00000000"
            anchors.verticalCenter: parent.verticalCenter
            visible: true
            border.color: "#0000ff"
            anchors.horizontalCenter: mainHead.horizontalCenter
            border.width: 4
        }

        Rectangle {
            id: rectangle
            x: 0
            y: 46
            width: 710
            height: 4
            color: "#00000000"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            border.color: "#f2f2f2"
            border.width: 2
        }

        Text {
            id: timeHead
            x: 4
            y: 0
            color: "#b0acac"
            text: qsTr("TIMING")
            styleColor: "#0000ff"
            anchors.leftMargin: 50
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 28
            anchors.left: mainHead.right
            anchors.verticalCenterOffset: 3
            font.family: "BN Elements"
        }

        Text {
            id: teleHead
            x: 0
            y: 4
            color: "#b0acac"
            text: qsTr("TELEMETRY")
            styleColor: "#0000ff"
            anchors.leftMargin: 50
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 28
            anchors.left: timeHead.right
            anchors.verticalCenterOffset: 3
            font.family: "BN Elements"
        }

        Text {
            id: configHead
            x: 5
            y: -3
            color: "#b0acac"
            text: qsTr("CONFIG")
            styleColor: "#0000ff"
            anchors.leftMargin: 50
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 28
            anchors.left: teleHead.right
            anchors.verticalCenterOffset: 3
            font.family: "BN Elements"
        }

        Item {
            id: mainPage
            x: 0
            y: 36
            width: 710
            height: 512

            Rectangle {
                id: posBg
                width: 215
                height: 110
                color: "#00000000"
                radius: 0
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 10
                Text {
                    id: posDisp
                    text: qsTr("P11")
                    anchors.verticalCenterOffset: -5
                    horizontalAlignment: Text.AlignHCenter
                    font.italic: false
                    font.family: "Mont Heavy DEMO"
                    font.bold: false
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 90
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    id: posLabel
                    text: qsTr("POSITION")
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    font.pixelSize: 15
                    font.family: "BN Elements"
                }
                border.width: 4
            }

            Rectangle {
                id: lapBg
                x: 315
                y: 101
                width: 215
                height: 110
                color: "#00000000"
                radius: 0
                anchors.left: posBg.right
                anchors.leftMargin: 20
                anchors.verticalCenter: posBg.verticalCenter

                Text {
                    id: lapLabel
                    text: qsTr("LAP")
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    font.pixelSize: 15
                    font.family: "BN Elements"
                }
                border.width: 4
                Text {
                    id: lapDisp
                    width: 130
                    text: qsTr("L114")
                    horizontalAlignment: Text.AlignHCenter
                    font.bold: false
                    font.family: "Mont Heavy DEMO"
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 90
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            Rectangle {
                id: lastLapBg
                x: 150
                y: 241
                width: 450
                height: 150
                color: "#00000000"
                radius: 0
                anchors.top: posBg.bottom
                anchors.topMargin: 10
                Text {
                    id: lastLapDisp
                    width: 440
                    text: qsTr("0:45.14")
                    font.bold: true
                    font.family: "Mont Heavy DEMO"
                    anchors.verticalCenterOffset: -10
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 130
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    id: lastLapLabel
                    text: qsTr("LAST LAP")
                    anchors.left: parent.left
                    anchors.leftMargin: 7
                    anchors.bottom: parent.bottom
                    font.pixelSize: 20
                    font.family: "BN Elements"
                    anchors.bottomMargin: 0
                }
                anchors.leftMargin: 0
                anchors.left: posBg.left
                border.width: 5
            }

            Rectangle {
                id: lastDeltaBg
                width: 230
                height: 150
                color: "#00ff00"
                radius: 0
                anchors.left: lastLapBg.right
                anchors.leftMargin: 10
                anchors.verticalCenter: lastLapBg.verticalCenter
                Text {
                    id: lastDeltaDisp
                    text: qsTr("+4.32")
                    font.bold: true
                    font.family: "Mont Heavy DEMO"
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 80
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    id: lastDeltaLabel
                    height: 23
                    text: qsTr("DELTA")
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    font.pixelSize: 20
                    font.family: "BN Elements"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                border.width: 4
            }

            Rectangle {
                id: lapTimerBg
                x: 318
                y: 100
                width: 230
                height: 110
                color: "#00000000"
                radius: 0
                anchors.leftMargin: 10
                anchors.verticalCenter: posBg.verticalCenter
                Text {
                    id: lapDisp1
                    width: 130
                    text: qsTr("0:32.54")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 65
                    horizontalAlignment: Text.AlignHCenter
                    font.bold: false
                    font.family: "Mont Heavy DEMO"
                }

                Text {
                    id: lapTimerLabel
                    text: qsTr("CURRENT LAP")
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 5
                    font.pixelSize: 15
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    font.family: "BN Elements"
                }
                anchors.left: lapBg.right
                border.width: 4
            }

            Rectangle {
                id: lapTimerBg1
                x: 317
                width: 250
                height: 125
                color: "#00000000"
                radius: 0
                anchors.top: lastDeltaBg.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: lastDeltaBg.horizontalCenter
                anchors.leftMargin: 10
                Text {
                    id: lapDisp2
                    width: 130
                    text: qsTr("0:32.54")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 65
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Mont Heavy DEMO"
                    font.bold: false
                }

                Text {
                    id: lapTimerLabel1
                    text: qsTr("CURRENT LAP")
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 5
                    font.pixelSize: 15
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    font.family: "BN Elements"
                }
                anchors.left: lapBg.right
                border.width: 4
            }

            Image {
                id: teamUpLabel
                width: 50
                height: 50
                anchors.top: lastLapBg.bottom
                anchors.topMargin: 15
                anchors.left: lastLapBg.right
                anchors.leftMargin: -450
                fillMode: Image.PreserveAspectFit
                source: "images/triangle_black.png"

                Rectangle {
                    id: upTeamNumBg
                    x: 72
                    y: -166
                    width: 100
                    height: 60
                    color: "#00000000"
                    radius: 0
                    anchors.left: parent.right
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    border.width: 3

                    Text {
                        id: upTeamNumDisp
                        text: qsTr("666")
                        font.family: "Mont Heavy DEMO"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 50
                    }
                }

                Rectangle {
                    id: upTeamLapBg
                    x: 72
                    y: -175
                    width: 120
                    height: 60
                    color: "#00000000"
                    radius: 0
                    border.width: 3
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: upTeamNumBg.right
                    Text {
                        id: upTeamLapVal
                        width: 125
                        text: qsTr("+23L")
                        font.family: "Mont Heavy DEMO"
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 50
                    }
                    anchors.leftMargin: 10
                }

                Rectangle {
                    id: upTeamDeltaBg
                    y: -177
                    width: 150
                    height: 60
                    color: "#00ff00"
                    radius: 0
                    border.width: 3
                    anchors.left: upTeamLapBg.right
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        id: upTeamDeltaDisp
                        text: qsTr("+5.34")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 50
                    }
                    anchors.leftMargin: 10
                }
            }

            Image {
                id: teamUpLabel1
                x: -5
                width: 50
                height: 50
                rotation: 180
                anchors.horizontalCenter: teamUpLabel.horizontalCenter
                anchors.top: teamUpLabel.bottom
                fillMode: Image.PreserveAspectFit
                anchors.topMargin: 15
                anchors.leftMargin: -450
                source: "images/triangle_black.png"
                anchors.left: lastLapBg.right
            }

            Rectangle {
                id: upTeamNumBg2
                x: 53
                width: 100
                height: 60
                color: "#00000000"
                radius: 0
                anchors.top: teamUpLabel.bottom
                anchors.topMargin: 10
                anchors.leftMargin: 10
                Text {
                    id: upTeamNumDisp2
                    text: qsTr("13")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 50
                    font.family: "Mont Heavy DEMO"
                }

                Rectangle {
                    id: upTeamLapBg2
                    x: 110
                    y: 0
                    width: 120
                    height: 60
                    color: "#00000000"
                    radius: 0
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        id: upTeamLapVal2
                        text: qsTr("-0L")
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 50
                        font.family: "Mont Heavy DEMO"
                    }
                    anchors.left: upTeamNumBg2.right
                    border.width: 3
                }

                Rectangle {
                    id: upTeamDeltaBg2
                    y: 72
                    width: 150
                    height: 60
                    color: "#ff0000"
                    radius: 0
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        id: upTeamDeltaDisp2
                        text: qsTr("+5.34")
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 50
                    }
                    anchors.left: upTeamLapBg2.right
                    border.width: 3
                }
                anchors.left: teamUpLabel.right
                border.width: 3
            }
        }
    }

}





/*##^##
Designer {
    D{i:62;anchors_width:150}D{i:57;anchors_x:10;anchors_y:286}D{i:64;anchors_x:10;anchors_y:4}
D{i:69;anchors_x:105}D{i:65;anchors_y:-14}
}
##^##*/
