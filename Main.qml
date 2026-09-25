import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Effects
import QtQuick.Shapes
import QtQml
import QtMultimedia


Window {
    id: root

    FontLoader {
        id: geologicaFont
        source: "resources/fonts/geologica.ttf"
    }

    FontLoader {
        id: spaceMonoFont
        source: "resources/fonts/SpaceMono-Bold.ttf"
    }

    // SoundEffect {
    //     id: tickSound
    //     source: "resources/sounds/tick.wav"
    // }

    SoundEffect {
        id: tickSound
        source: "resources/sounds/tick.wav"
        loops: SoundEffect.Infinite
        
    }

    SoundEffect {
        id: alarmSound
        source: "resources/sounds/alarm.wav"
        loops: 1
    }

    ThemeDark {
        id: theme
    }

    Material.theme: Material.Dark
    Material.accent: theme.accent
    // Material.primary: theme.accent

    flags: Qt.FramelessWindowHint

    width: 1024
    height: 640
    minimumHeight: 480
    minimumWidth: 640

    x: (Screen.width  - width)  / 2
    y: (Screen.height - height) / 2

    color: theme.background

    visible: true
    title: qsTr("Pomodoro by cathxrsys | v1.0.0")

    property var sessions: [
        { type: "work", text: "WORK", duration: 50 * 60 }, // work
        { type: "pause", text: "SHORT\nBREAK", duration: 5 * 60 }, // short break
        { type: "work", text: "WORK", duration: 50 * 60 }, // work
        { type: "pause", text: "SHORT\nBREAK", duration: 5 * 60 }, // short break
        { type: "work", text: "WORK", duration: 50 * 60 }, // work
        { type: "pause", text: "SHORT\nBREAK", duration: 5 * 60 }, // short break
        { type: "work", text: "WORK", duration: 50 * 60 }, // work
        { type: "pause", text: "SHORT\nBREAK", duration: 5 * 60 }, // short break
        { type: "work", text: "WORK", duration: 50 * 60 }, // work
        { type: "pause", text: "LONG\nBREAK", duration: 30 * 60 } // long break
    ]
    property int sessionIndex: 0
    property int max: sessions[sessionIndex].duration
    property int remaining: sessions[sessionIndex].duration

    Timer {
        id: pomodoroTimer
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            createWaveEffect()
            if (remaining > 0) {
                remaining--
            } else {
                pomodoroTimer.stop()
                running = false

                alarmSound.play()
                
                sessionIndex = (sessionIndex + 1) % sessions.length
                remaining = sessions[sessionIndex].duration
            }
        }
        onRunningChanged: {
            if (running) {
                tickSound.play()
            } else {
                tickSound.stop()
            }
        }
    }

    // Timer {
    //     interval: 1250
    //     running: pomodoroTimer.running
    //     repeat: true
    //     onTriggered: {
    //         tickSound.play()
    //     }
    // }

    function createWaveEffect() {
        var component = Qt.createComponent("qrc:/qt/qml/client/CircleWave.qml")
        if (component.status === Component.Ready) {
            var wave = component.createObject(waveContainer, {
                "autoStart": true,
            })
        }
    }

    // // Левый край
    // MouseArea {
    //     anchors.left: parent.left
    //     anchors.top: parent.top
    //     anchors.bottom: parent.bottom
    //     width: 5
    //     cursorShape: Qt.SizeHorCursor
    //     onPressed: root.startSystemResize(Qt.LeftEdge)
    //     z: 500
    // }

    // // Правый край
    // MouseArea {
    //     anchors.right: parent.right
    //     anchors.top: parent.top
    //     anchors.bottom: parent.bottom
    //     width: 5
    //     cursorShape: Qt.SizeHorCursor
    //     onPressed: root.startSystemResize(Qt.RightEdge)
    //     z: 500
    // }

    // // Верхний край
    // MouseArea {
    //     anchors.top: parent.top
    //     anchors.left: parent.left
    //     anchors.right: parent.right
    //     height: 5
    //     cursorShape: Qt.SizeVerCursor
    //     onPressed: root.startSystemResize(Qt.TopEdge)
    //     z: 500
    // }

    // // Нижний край
    // MouseArea {
    //     anchors.bottom: parent.bottom
    //     anchors.left: parent.left
    //     anchors.right: parent.right
    //     height: 5
    //     cursorShape: Qt.SizeVerCursor
    //     onPressed: root.startSystemResize(Qt.BottomEdge)
    //     z: 500
    // }


    Rectangle { // Верхняя панель
        id: topPanel
        width: parent.width
        height: 25

        z: 300

        color: theme.background

        RowLayout { 
            id: topPanel2
            width: parent.width
            height: 25



            
            Rectangle {
                // Layout.fillWidth: true
                // Layout.maximumWidth: 80
                Layout.fillHeight: true
                // color: theme.background
                color: "transparent"

                Image {
                    source: "resources/icon.svg"
                
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter

                    width: 10
                    height: 10

                    // sourceSize: Qt.size(width*1,height*1)
                    mipmap: true

                    antialiasing: true
                    smooth: true

                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                        anchors.fill: parent
                        onPressed: {
                            root.startSystemMove()
                        }
                    }
                }

                Text {
                    text: "Pomodoro by cathxrsys | v1.0.0"

                    color: theme.accent

                    font.pixelSize: 10
                    font.family: "Inter"
                    font.weight: Font.ExtraBold

                    anchors.left: parent.left
                    anchors.leftMargin: 25
                    anchors.verticalCenter: parent.verticalCenter

                    MouseArea {
                        anchors.fill: parent
                        onPressed: {
                            root.startSystemMove()
                        }
                    }
                }
            }

            MouseArea {
                Layout.fillWidth: true
                Layout.fillHeight: true

                // cursorShape: Qt.SizeAllCursor
                
                onPressed: {
                    root.startSystemMove()
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignRight
                Layout.fillHeight: true
                Layout.fillWidth: true

                Layout.margins: 0
                Layout.bottomMargin: 0
                Layout.topMargin: 0
                Layout.rightMargin: 0
                Layout.leftMargin: 0

                spacing: 0 // Убирает зазоры между кнопками

                PanelButton {
                    Layout.alignment: Qt.AlignRight
                    
                    icon.source: "resources/minimize.svg"

                    icon.width: 4
                    icon.height: 1

                    icon.color: theme.accent
                    onClicked: {
                        root.showMinimized()
                    }
                }

                PanelButton {
                    Layout.alignment: Qt.AlignRight
                    enabled: false
                    icon.source: "resources/maximize.svg"
                    icon.color: enabled ? theme.accent : theme.lowAccent
                    onClicked: {
                        if (root.visibility === Window.Maximized) {
                            root.showNormal()
                        } else {
                            root.showMaximized()
                        }
                    }
                }

                PanelButton {
                    id: closeButton
                    Layout.alignment: Qt.AlignRight
                    
                    icon.source: "resources/close.svg"
                    icon.color: theme.accent
                    onClicked: {
                        root.close()
                    }

                    HoverHandler {
                        onHoveredChanged: {
                            closeButton.panelBackground = hovered ? theme.redAccent : "transparent"
                            closeButton.icon.color = hovered ? theme.background : theme.accent
                        }
                    }
                }
            }
        } 
    } // Верхняя панель

    Rectangle {
        id: contentArea
        anchors.top: topPanel.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        color: "transparent"

        Rectangle {
            id: statusBar
            width: parent.width * 0.7
            height: 1
            color: theme.lowAccent
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 100
        }

        Rectangle {
            id: statusIndicator

            // property real progress: 1.0 - root.remaining / root.max
            property real progress: (statusBar.width) * (1.0 - root.remaining / root.max)


            anchors.verticalCenter: statusBar.verticalCenter
            width: 10
            height: 10
            radius: 5
            color: theme.accent
            anchors.left: statusBar.left
            anchors.leftMargin: -5 + progress

            Behavior on anchors.leftMargin {
                NumberAnimation { duration: 500; easing.type: Easing.InOutQuad }
            }
        }

        Rectangle {
            id: sessionsContainer
            width: statusBar.width
            height: 40
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: statusBar.bottom
            anchors.topMargin: 20

            Row {
                width: parent.width
                height: parent.height

                spacing: 0

                Repeater {
                    model: root.sessions.length
                    Rectangle {

                        Behavior on color {
                            ColorAnimation { duration: 150; easing.type: Easing.InOutQuad }
                        }


                        width: (sessionsContainer.width / root.sessions.length) 
                        height: sessionsContainer.height
                        color: index === root.sessionIndex ? theme.accent : theme.lowestAccent

                        HoverHandler { id: hoverHandler }
                        opacity: index === root.sessionIndex ? 1.0 : (hoverHandler.hovered ? 1.0 : 0.8)

                        Behavior on opacity {
                            NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
                        }

                        Text {
                            text: sessions[index].text
                            color: theme.background
                            font.pixelSize: parent.height * 0.2
                            font.family: geologicaFont.name
                            font.weight: Font.Bold
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                root.sessionIndex = index
                                root.remaining = root.sessions[root.sessionIndex].duration
                                pomodoroTimer.stop()
                            }
                        }
                    }
                }
            }
        }

        Item {
            id: waveContainer
            anchors.fill: parent
            z: 90
        }

        Image {
            id: tomatoImage
            source: "resources/tomato.svg"

            width: parent.width * 0.2
            height: parent.width * 0.2

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            fillMode: Image.PreserveAspectFit
            mipmap: true
            antialiasing: true
            smooth: true

            z: 100;

            Text {
                id: currentAction
                text: pomodoroTimer.running ? (sessions[sessionIndex].type === "work" ? "FOCUS" : "BREAK") : "PAUSED"
                color: theme.background
                font.pixelSize: tomatoImage.height * 0.15
                font.family: geologicaFont.name
                font.weight: Font.Bold
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 15
                anchors.horizontalCenterOffset: 5
            }
        }

        Text {
            id: timerText
            text: {
                var minutes = Math.floor(root.remaining / 60)
                var seconds = root.remaining % 60
                return (minutes < 10 ? "0" + minutes : minutes) + "   " + (seconds < 10 ? "0" + seconds : seconds)
            }
            color: theme.accent
            font.pixelSize: 170
            font.family: spaceMonoFont.name
            font.weight: Font.Bold
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            // anchors.verticalCenterOffset: 100

            smooth: true
            antialiasing: true

            z: 99;
        }

        Image {
            id: donateIcon
            source: "resources/donate.svg"
            width: 40
            height: 40
            anchors.left: statusBar.left
            anchors.bottom: playPauseMask.bottom
            smooth: true
            antialiasing: true
            
            mipmap: true

            HoverHandler { id: hover }
            opacity: hover.hovered ? 1.0 : 0.6

            Behavior on opacity {
                NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    Qt.openUrlExternally("https://github.com/cathxrsys/pomodoro/blob/main/DONATE.md")
                }
            }
        }

        Image {
            id: githubIcon
            source: "resources/github.svg"
            width: 40
            height: 40
            anchors.right: statusBar.right
            anchors.bottom: playPauseMask.bottom
            smooth: true
            antialiasing: true
            
            mipmap: true

            HoverHandler { id: githubHover }
            opacity: githubHover.hovered ? 1.0 : 0.6

            Behavior on opacity {
                NumberAnimation { duration: 200; easing.type: Easing.InOutQuad }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    Qt.openUrlExternally("https://github.com/cathxrsys/pomodoro")
                }
            }
        }

        Image {
            id: playPauseMask
            visible: false
            source: pomodoroTimer.running ? "resources/pause.svg" : "resources/play.svg"
            width: 40
            height: 40

            fillMode: Image.PreserveAspectFit
            mipmap: true
            antialiasing: true
            smooth: true

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: contentArea.bottom
            anchors.bottomMargin: 100
        }

        Rectangle {
            id: playPauseOverlay
            color: theme.accent // Или свойство с нужным цветом
            anchors.fill: playPauseMask
            visible: false
        }

        MultiEffect {
            id: playPauseIcon
            anchors.fill: playPauseMask
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: contentArea.bottom

            source: playPauseOverlay
            maskEnabled: true
            maskSource: playPauseMask

            visible: true
            layer.enabled: true
            layer.smooth: true

            maskSpreadAtMin: 1.0
            maskThresholdMin: 0.6

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (pomodoroTimer.running) {
                        pomodoroTimer.stop()
                    } else {
                        pomodoroTimer.start()
                    }
                }
                cursorShape: Qt.PointingHandCursor
            }
        }

    }

}
