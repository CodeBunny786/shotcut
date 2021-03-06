

import QtQuick 2.1
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.0
import Shotcut.Controls 1.0


Item {
    width: 350
    height: 200
    property bool blockUpdate: true

    property double yawStart : 0.0; property double yawMiddle : 0.0; property double yawEnd : 0.0;
    property double pitchStart : 0.0; property double pitchMiddle : 0.0; property double pitchEnd : 0.0;
    property double rollStart : 0.0; property double rollMiddle : 0.0; property double rollEnd : 0.0;
    property double fovStart : 0.0; property double fovMiddle : 0.0; property double fovEnd : 0.0;
    property double fisheyeStart : 0.0; property double fisheyeMiddle : 0.0; property double fisheyeEnd : 0.0;
    property int interpolationValue : 0;

    Connections { target: filter; onChanged: setControls(); onInChanged: { updateProperty_yaw (null); } onOutChanged: { updateProperty_yaw (null); } onAnimateInChanged: { updateProperty_yaw (null); } onAnimateOutChanged: { updateProperty_yaw (null); } }
    Connections { target: filter; onChanged: setControls(); onInChanged: { updateProperty_pitch (null); } onOutChanged: { updateProperty_pitch (null); } onAnimateInChanged: { updateProperty_pitch (null); } onAnimateOutChanged: { updateProperty_pitch (null); } }
    Connections { target: filter; onChanged: setControls(); onInChanged: { updateProperty_roll (null); } onOutChanged: { updateProperty_roll (null); } onAnimateInChanged: { updateProperty_roll (null); } onAnimateOutChanged: { updateProperty_roll (null); } }
    Connections { target: filter; onChanged: setControls(); onInChanged: { updateProperty_fov (null); } onOutChanged: { updateProperty_fov (null); } onAnimateInChanged: { updateProperty_fov (null); } onAnimateOutChanged: { updateProperty_fov (null); } }
    Connections { target: filter; onChanged: setControls(); onInChanged: { updateProperty_fisheye (null); } onOutChanged: { updateProperty_fisheye (null); } onAnimateInChanged: { updateProperty_fisheye (null); } onAnimateOutChanged: { updateProperty_fisheye (null); } }
    Connections { target: filter; onChanged: setControls(); onInChanged: { updateProperty_interpolation (); } onOutChanged: { updateProperty_interpolation (); } onAnimateInChanged: { updateProperty_interpolation (); } onAnimateOutChanged: { updateProperty_interpolation (); } }

    Component.onCompleted: {
        if (filter.isNew) { filter.set("yaw", 0); } else { yawMiddle = filter.getDouble("yaw", filter.animateIn); if (filter.animateIn > 0) { yawStart = filter.getDouble("yaw", 0); } if (filter.animateOut > 0) { yawEnd = filter.getDouble("yaw", filter.duration - 1); } }
        if (filter.isNew) { filter.set("pitch", 0); } else { pitchMiddle = filter.getDouble("pitch", filter.animateIn); if (filter.animateIn > 0) { pitchStart = filter.getDouble("pitch", 0); } if (filter.animateOut > 0) { pitchEnd = filter.getDouble("pitch", filter.duration - 1); } }
        if (filter.isNew) { filter.set("roll", 0); } else { rollMiddle = filter.getDouble("roll", filter.animateIn); if (filter.animateIn > 0) { rollStart = filter.getDouble("roll", 0); } if (filter.animateOut > 0) { rollEnd = filter.getDouble("roll", filter.duration - 1); } }
        if (filter.isNew) { filter.set("fov", 90); } else { fovMiddle = filter.getDouble("fov", filter.animateIn); if (filter.animateIn > 0) { fovStart = filter.getDouble("fov", 0); } if (filter.animateOut > 0) { fovEnd = filter.getDouble("fov", filter.duration - 1); } }
        if (filter.isNew) { filter.set("fisheye", 0); } else { fisheyeMiddle = filter.getDouble("fisheye", filter.animateIn); if (filter.animateIn > 0) { fisheyeStart = filter.getDouble("fisheye", 0); } if (filter.animateOut > 0) { fisheyeEnd = filter.getDouble("fisheye", filter.duration - 1); } }
        if (filter.isNew) { filter.set("interpolation", 1); } else { interpolationValue = filter.get("interpolation"); }

        if (filter.isNew) {
            filter.savePreset(preset.parameters)
        }
        setControls()
    }

    function setControls() {
        var position = getPosition()
        blockUpdate = true
        yawSlider.value = filter.getDouble("yaw", position)
        pitchSlider.value = filter.getDouble("pitch", position)
        rollSlider.value = filter.getDouble("roll", position)
        fovSlider.value = filter.getDouble("fov", position)
        fisheyeSlider.value = filter.getDouble("fisheye", position)
        interpolationComboBox.currentIndex = filter.get("interpolation")
        blockUpdate = false
    }

    function updateProperty_yaw (position) { if (blockUpdate) return; var value = yawSlider.value; if (position !== null) { if (position <= 0 && filter.animateIn > 0) { yawStart = value; } else if (position >= filter.duration - 1 && filter.animateOut > 0) { yawEnd = value; } else { yawMiddle = value; } } if (filter.animateIn > 0 || filter.animateOut > 0) { filter.resetProperty("yaw"); yawKeyframesButton.checked = false; if (filter.animateIn > 0) { filter.set("yaw", yawStart, 0); filter.set("yaw", yawMiddle, filter.animateIn - 1); } if (filter.animateOut > 0) { filter.set("yaw", yawMiddle, filter.duration - filter.animateOut); filter.set("yaw", yawEnd, filter.duration - 1); } } else if (!yawKeyframesButton.checked) { filter.resetProperty("yaw"); filter.set("yaw", yawMiddle); } else if (position !== null) { filter.set("yaw", value, position); } }
    function updateProperty_pitch (position) { if (blockUpdate) return; var value = pitchSlider.value; if (position !== null) { if (position <= 0 && filter.animateIn > 0) { pitchStart = value; } else if (position >= filter.duration - 1 && filter.animateOut > 0) { pitchEnd = value; } else { pitchMiddle = value; } } if (filter.animateIn > 0 || filter.animateOut > 0) { filter.resetProperty("pitch"); pitchKeyframesButton.checked = false; if (filter.animateIn > 0) { filter.set("pitch", pitchStart, 0); filter.set("pitch", pitchMiddle, filter.animateIn - 1); } if (filter.animateOut > 0) { filter.set("pitch", pitchMiddle, filter.duration - filter.animateOut); filter.set("pitch", pitchEnd, filter.duration - 1); } } else if (!pitchKeyframesButton.checked) { filter.resetProperty("pitch"); filter.set("pitch", pitchMiddle); } else if (position !== null) { filter.set("pitch", value, position); } }
    function updateProperty_roll (position) { if (blockUpdate) return; var value = rollSlider.value; if (position !== null) { if (position <= 0 && filter.animateIn > 0) { rollStart = value; } else if (position >= filter.duration - 1 && filter.animateOut > 0) { rollEnd = value; } else { rollMiddle = value; } } if (filter.animateIn > 0 || filter.animateOut > 0) { filter.resetProperty("roll"); rollKeyframesButton.checked = false; if (filter.animateIn > 0) { filter.set("roll", rollStart, 0); filter.set("roll", rollMiddle, filter.animateIn - 1); } if (filter.animateOut > 0) { filter.set("roll", rollMiddle, filter.duration - filter.animateOut); filter.set("roll", rollEnd, filter.duration - 1); } } else if (!rollKeyframesButton.checked) { filter.resetProperty("roll"); filter.set("roll", rollMiddle); } else if (position !== null) { filter.set("roll", value, position); } }
    function updateProperty_fov (position) { if (blockUpdate) return; var value = fovSlider.value; if (position !== null) { if (position <= 0 && filter.animateIn > 0) { fovStart = value; } else if (position >= filter.duration - 1 && filter.animateOut > 0) { fovEnd = value; } else { fovMiddle = value; } } if (filter.animateIn > 0 || filter.animateOut > 0) { filter.resetProperty("fov"); fovKeyframesButton.checked = false; if (filter.animateIn > 0) { filter.set("fov", fovStart, 0); filter.set("fov", fovMiddle, filter.animateIn - 1); } if (filter.animateOut > 0) { filter.set("fov", fovMiddle, filter.duration - filter.animateOut); filter.set("fov", fovEnd, filter.duration - 1); } } else if (!fovKeyframesButton.checked) { filter.resetProperty("fov"); filter.set("fov", fovMiddle); } else if (position !== null) { filter.set("fov", value, position); } }
    function updateProperty_fisheye (position) { if (blockUpdate) return; var value = fisheyeSlider.value; if (position !== null) { if (position <= 0 && filter.animateIn > 0) { fisheyeStart = value; } else if (position >= filter.duration - 1 && filter.animateOut > 0) { fisheyeEnd = value; } else { fisheyeMiddle = value; } } if (filter.animateIn > 0 || filter.animateOut > 0) { filter.resetProperty("fisheye"); fisheyeKeyframesButton.checked = false; if (filter.animateIn > 0) { filter.set("fisheye", fisheyeStart, 0); filter.set("fisheye", fisheyeMiddle, filter.animateIn - 1); } if (filter.animateOut > 0) { filter.set("fisheye", fisheyeMiddle, filter.duration - filter.animateOut); filter.set("fisheye", fisheyeEnd, filter.duration - 1); } } else if (!fisheyeKeyframesButton.checked) { filter.resetProperty("fisheye"); filter.set("fisheye", fisheyeMiddle); } else if (position !== null) { filter.set("fisheye", value, position); } }
    function updateProperty_interpolation () { if (blockUpdate) return; var value = interpolationComboBox.currentIndex; filter.set("interpolation", value); }

    function getPosition() {
        return Math.max(producer.position - (filter.in - producer.in), 0)
    }

    GridLayout {
        columns: 4
        anchors.fill: parent
        anchors.margins: 8

        Label {
            text: qsTr('Preset')
            Layout.alignment: Qt.AlignRight
        }
        Preset {
            id: preset
            parameters: ["yaw", "pitch", "roll", "fov", "interpolation", "fisheye"]
            Layout.columnSpan: 3
            onBeforePresetLoaded: {
                filter.resetProperty('yaw')
                filter.resetProperty('pitch')
                filter.resetProperty('roll')
                filter.resetProperty('fov')
                filter.resetProperty('fisheye')
                filter.resetProperty('interpolation')
            }
            onPresetSelected: {
                yawMiddle = filter.getDouble("yaw", filter.animateIn); if (filter.animateIn > 0) { yawStart = filter.getDouble("yaw", 0); } if (filter.animateOut > 0) { yawEnd = filter.getDouble("yaw", filter.duration - 1); }
                pitchMiddle = filter.getDouble("pitch", filter.animateIn); if (filter.animateIn > 0) { pitchStart = filter.getDouble("pitch", 0); } if (filter.animateOut > 0) { pitchEnd = filter.getDouble("pitch", filter.duration - 1); }
                rollMiddle = filter.getDouble("roll", filter.animateIn); if (filter.animateIn > 0) { rollStart = filter.getDouble("roll", 0); } if (filter.animateOut > 0) { rollEnd = filter.getDouble("roll", filter.duration - 1); }
                fovMiddle = filter.getDouble("fov", filter.animateIn); if (filter.animateIn > 0) { fovStart = filter.getDouble("fov", 0); } if (filter.animateOut > 0) { fovEnd = filter.getDouble("fov", filter.duration - 1); }
                fisheyeMiddle = filter.getDouble("fisheye", filter.animateIn); if (filter.animateIn > 0) { fisheyeStart = filter.getDouble("fisheye", 0); } if (filter.animateOut > 0) { fisheyeEnd = filter.getDouble("fisheye", filter.duration - 1); }
                interpolationValue = filter.get("interpolation");
                setControls(null);
            }
        }

        Label {
            text: qsTr('Interpolation')
            Layout.alignment: Qt.AlignRight
        }
        ComboBox {
            currentIndex: 0
            model: ["Nearest-neighbor", "Bilinear"]
            id: interpolationComboBox
            Layout.columnSpan: 2
            onCurrentIndexChanged: updateProperty_interpolation()
        }
        UndoButton {
            id: interpolationUndo
            onClicked: interpolationComboBox.currentIndex = 0
        }

        Label {
            text: qsTr('Yaw')
            Layout.alignment: Qt.AlignRight
        }
        SliderSpinner {
            id: yawSlider
            minimumValue: -360
            maximumValue: 360
            spinnerWidth: 120; suffix: ' deg'; decimals: 3; stepSize: 1;
            onValueChanged: updateProperty_yaw(getPosition())
        }
        KeyframesButton { id: yawKeyframesButton; checked: filter.animateIn <= 0 && filter.animateOut <= 0 && filter.keyframeCount("yaw") > 0; onToggled: { var value = yawSlider.value; if (checked) { blockUpdate = true; if (filter.animateIn > 0 || filter.animateOut > 0) { filter.resetProperty("yaw"); yawSlider.enabled = true; } filter.clearSimpleAnimation("yaw"); blockUpdate = false; filter.set("yaw", value, getPosition()); } else { filter.resetProperty("yaw"); filter.set("yaw", value); } } }
        UndoButton {
            id: yawUndo
            onClicked: yawSlider.value = 0
        }

        Label {
            text: qsTr('Pitch')
            Layout.alignment: Qt.AlignRight
        }
        SliderSpinner {
            id: pitchSlider
            minimumValue: -180
            maximumValue: 180
            spinnerWidth: 120; suffix: ' deg'; decimals: 3; stepSize: 1;
            onValueChanged: updateProperty_pitch(getPosition())
        }
        KeyframesButton { id: pitchKeyframesButton; checked: filter.animateIn <= 0 && filter.animateOut <= 0 && filter.keyframeCount("pitch") > 0; onToggled: { var value = pitchSlider.value; if (checked) { blockUpdate = true; if (filter.animateIn > 0 || filter.animateOut > 0) { filter.resetProperty("pitch"); pitchSlider.enabled = true; } filter.clearSimpleAnimation("pitch"); blockUpdate = false; filter.set("pitch", value, getPosition()); } else { filter.resetProperty("pitch"); filter.set("pitch", value); } } }
        UndoButton {
            id: pitchUndo
            onClicked: pitchSlider.value = 0
        }

        Label {
            text: qsTr('Roll')
            Layout.alignment: Qt.AlignRight
        }
        SliderSpinner {
            id: rollSlider
            minimumValue: -180
            maximumValue: 180
            spinnerWidth: 120; suffix: ' deg'; decimals: 3; stepSize: 1;
            onValueChanged: updateProperty_roll(getPosition())
        }
        KeyframesButton { id: rollKeyframesButton; checked: filter.animateIn <= 0 && filter.animateOut <= 0 && filter.keyframeCount("roll") > 0; onToggled: { var value = rollSlider.value; if (checked) { blockUpdate = true; if (filter.animateIn > 0 || filter.animateOut > 0) { filter.resetProperty("roll"); rollSlider.enabled = true; } filter.clearSimpleAnimation("roll"); blockUpdate = false; filter.set("roll", value, getPosition()); } else { filter.resetProperty("roll"); filter.set("roll", value); } } }
        UndoButton {
            id: rollUndo
            onClicked: rollSlider.value = 0
        }

        Label {
            text: qsTr('FOV')
            Layout.alignment: Qt.AlignRight
        }
        SliderSpinner {
            id: fovSlider
            minimumValue: 0
            maximumValue: 720
            spinnerWidth: 120; suffix: ' deg'; decimals: 3; stepSize: 1;
            onValueChanged: updateProperty_fov(getPosition())
        }
        KeyframesButton { id: fovKeyframesButton; checked: filter.animateIn <= 0 && filter.animateOut <= 0 && filter.keyframeCount("fov") > 0; onToggled: { var value = fovSlider.value; if (checked) { blockUpdate = true; if (filter.animateIn > 0 || filter.animateOut > 0) { filter.resetProperty("fov"); fovSlider.enabled = true; } filter.clearSimpleAnimation("fov"); blockUpdate = false; filter.set("fov", value, getPosition()); } else { filter.resetProperty("fov"); filter.set("fov", value); } } }
        UndoButton {
            id: fovUndo
            onClicked: fovSlider.value = 90
        }

        Label {
            text: qsTr('Fisheye')
            Layout.alignment: Qt.AlignRight
        }
        SliderSpinner {
            id: fisheyeSlider
            minimumValue: 0
            maximumValue: 100
            suffix: ' %'
            decimals: 0
            stepSize: 1
            onValueChanged: updateProperty_fisheye(getPosition())
        }
        KeyframesButton { id: fisheyeKeyframesButton; checked: filter.animateIn <= 0 && filter.animateOut <= 0 && filter.keyframeCount("fisheye") > 0; onToggled: { var value = fisheyeSlider.value; if (checked) { blockUpdate = true; if (filter.animateIn > 0 || filter.animateOut > 0) { filter.resetProperty("fisheye"); fisheyeSlider.enabled = true; } filter.clearSimpleAnimation("fisheye"); blockUpdate = false; filter.set("fisheye", value, getPosition()); } else { filter.resetProperty("fisheye"); filter.set("fisheye", value); } } }
        UndoButton {
            id: fisheyeUndo
            onClicked: fisheyeSlider.value = 0
        }
        Item {
            Layout.fillHeight: true
        }
    }

    Connections {
        target: producer
        onPositionChanged: setControls()
    }
}
