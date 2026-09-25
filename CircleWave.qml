import QtQuick

Rectangle {
    id: waveShape

    ThemeDark {
        id: theme
    }

    property color waveColor: theme.lowestAccent
    property int duration: 1500
    property real maxRadius: 800
    property bool autoStart: false

    property real animProgress: 0.0

    width: animProgress * maxRadius * 2
    height: animProgress * maxRadius * 2
    radius: width / 2
    
    color: waveColor
    opacity: 1.0 - (animProgress * 1.3)

    anchors.centerIn: parent

    SequentialAnimation on animProgress {
        loops: 1
        running: autoStart
        PropertyAnimation { from: 0.0; to: 1.0; duration: duration }
        ScriptAction { script: waveShape.destroy() }
    }
}