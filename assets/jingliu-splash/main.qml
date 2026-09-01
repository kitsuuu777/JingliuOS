import QtQuick
import QtQuick.Window

Window {
    id: root

    visible: true
    visibility: Window.FullScreen
    color: "transparent"

    property real progress: 0.0
    property bool finished: false
    property bool ready: false
    property var readyRequest: null

    readonly property string readyFile:
        "file:///run/user/1000/jingliu-ready.flag"

    readonly property string bootStatus:
        progress < 0.25 ? "Initializing..." :
        progress < 0.55 ? "Loading core..." :
        progress < 0.80 ? "Preparing session..." :
        progress < 1.0 ? "Starting compositor..." :
        "Ready."

    function checkReady() {
        if (root.ready || root.readyRequest !== null)
            return

        var xhr = new XMLHttpRequest()
        root.readyRequest = xhr

        xhr.onreadystatechange = function() {
            if (xhr.readyState !== XMLHttpRequest.DONE)
                return

            root.readyRequest = null

            /*
             * file:// URLs mogą zwrócić status 0 zamiast 200.
             * Dlatego akceptujemy zarówno 200, jak i 0,
             * ale wymagamy właściwej zawartości pliku.
             */
            if ((xhr.status === 200 || xhr.status === 0) &&
                    xhr.responseText.trim() === "ready") {
                root.ready = true
            }
        }

        xhr.open("GET", root.readyFile)
        xhr.send()
    }

    onReadyChanged: {
        if (ready && !finished) {
            readyAnimation.start()
        }
    }

    onProgressChanged: {
        if (progress >= 1.0 && !finished) {
            finished = true
            readyTimer.stop()
            exitAnimation.start()
        }
    }

    FontLoader {
        id: jingliuFont
        source: "assets/fonts/SpaceGrotesk-Regular.ttf"
    }

    FontLoader {
        id: kitsuFont
        source: "assets/fonts/Cinzel-Regular.ttf"
    }

    Item {
        id: splashRoot

        anchors.fill: parent

        Rectangle {
            anchors.fill: parent

            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "#070b16"
                }

                GradientStop {
                    position: 1.0
                    color: "#17243d"
                }
            }
        }

        Column {
            anchors.centerIn: parent
            spacing: 20

            Image {
                anchors.horizontalCenter: parent.horizontalCenter

                source: "assets/nixos-icon.png"

                width: 72
                height: 72

                fillMode: Image.PreserveAspectFit
                smooth: true
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 3

                text: "KITSU"

                color: "#e8e8ef"

                font.family: kitsuFont.name
                font.pixelSize: 34
                font.letterSpacing: 10
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter

                text: "JingliuOS"

                color: "#b9b4d8"

                font.family: jingliuFont.name
                font.pixelSize: 20
                font.letterSpacing: 4
            }

            Text {
                id: statusText

                anchors.horizontalCenter: parent.horizontalCenter

                text: root.bootStatus

                color: "#8c8a98"

                font.pixelSize: 16
                topPadding: 18

                Behavior on opacity {
                    NumberAnimation {
                        duration: 180
                        easing.type: Easing.OutCubic
                    }
                }
            }

            Rectangle {
                id: progressTrack

                width: 420
                height: 3

                radius: 1.5

                color: "#1a2230"

                Rectangle {
                    id: progressFill

                    height: parent.height
                    width: parent.width * root.progress

                    radius: parent.radius
                    clip: true

                    gradient: Gradient {
                        GradientStop {
                            position: 0.0
                            color: "#9ebcff"
                        }

                        GradientStop {
                            position: 0.8
                            color: "#d7e5ff"
                        }

                        GradientStop {
                            position: 1.0
                            color: "#ffffff"
                        }
                    }

                    Rectangle {
                        id: glint

                        width: 70
                        height: parent.height

                        x: -width

                        opacity: 0.65
                        color: "#ffffff"

                        SequentialAnimation on x {
                            loops: Animation.Infinite
                            running: root.progress > 0.05 && !root.finished

                            NumberAnimation {
                                from: -glint.width
                                to: progressFill.width + glint.width

                                duration: 950

                                easing.type: Easing.InOutSine
                            }

                            PauseAnimation {
                                duration: 500
                            }
                        }
                    }
                }
            }
        }
    }

    /*
     * Pierwsza część progressu:
     *
     * 0.00 → 0.68
     * 0.68 → pause
     * 0.68 → 0.92
     *
     * Po osiągnięciu 0.92 animacja się kończy
     * i splash czeka na prawdziwy READY.
     */
    SequentialAnimation {
        id: progressAnimation

        running: true

        NumberAnimation {
            target: root
            property: "progress"

            from: 0.0
            to: 0.68

            duration: 1100

            easing.type: Easing.OutCubic
        }

        PauseAnimation {
            duration: 450
        }

        NumberAnimation {
            target: root
            property: "progress"

            from: 0.68
            to: 0.92

            duration: 650

            easing.type: Easing.InOutCubic
        }

        PauseAnimation {
            duration: 300
        }
    }

    /*
     * Polling rzeczywistego stanu READY.
     *
     * Sprawdzamy co 100 ms.
     */
    Timer {
        id: readyTimer

        interval: 100
        repeat: true
        running: !root.finished

        onTriggered: {
            root.checkReady()
        }
    }

    /*
     * Gdy startup.sh utworzy marker:
     *
     * 0.92 → 1.00
     * Ready.
     */
    NumberAnimation {
        id: readyAnimation

        target: root
        property: "progress"

        from: 0.92
        to: 1.0

        duration: 300

        easing.type: Easing.OutCubic
    }

    /*
     * Finalny fade.
     */
    SequentialAnimation {
        id: exitAnimation

        NumberAnimation {
            target: splashRoot
            property: "opacity"

            from: 1.0
            to: 0.0

            duration: 1000

            easing.type: Easing.InOutCubic
        }

        onStopped: {
            Qt.quit()
        }
    }
}
