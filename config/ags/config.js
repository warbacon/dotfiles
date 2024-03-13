import brightness from "./services/brightness.js";

const hyprland = await Service.import("hyprland");
const systemtray = await Service.import("systemtray");
const battery = await Service.import("battery");
const audio = await Service.import("audio");
const network = await Service.import("network");

const date = Variable("", {
	poll: [1000, 'date "+%e %b %H:%M"'],
});

const WindowName = Widget.Label({
	label: hyprland.active.client.bind("title"),
});

function Workspaces() {
	const workspaces = hyprland.bind("workspaces");
	const activeId = hyprland.active.workspace.bind("id");
	return Widget.Box({
		class_name: "workspaces",
		children: workspaces.as((ws) => {
			ws.sort((a, b) => a.id > b.id);
			return ws.map(({ id }) =>
				Widget.Button({
					on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
					child: Widget.Label(`${id}`),
					class_name: activeId.as((i) => `${i === id ? "focused" : ""}`),
				}),
			);
		}),
	});
}

const Brightness = Widget.Icon({
	icon: "display-brightness-symbolic",
	tooltip_text: brightness
		.bind("screen-value")
		.as((v) => `Brillo: ${Math.floor(v * 100)}%`),
});

const VolumeIndicator = Widget.Button({
	class_name: "volume_indicator",
	on_primary_click: (self) => {
		self.toggleClassName(
			"active",
			self.class_names.includes("active") ? false : true,
		);
		App.toggleWindow("volumeMenu");
	},
	on_secondary_click: () => Utils.exec("pavucontrol"),
	on_middle_click: () =>
		(audio.speaker.stream.is_muted = !audio.speaker.stream.is_muted),
	child: Widget.Icon().hook(audio.speaker, (self) => {
		const vol = audio.speaker.volume * 100;
		const icon = audio.speaker.stream?.is_muted
			? "muted"
			: [
					[101, "overamplified"],
					[67, "high"],
					[34, "medium"],
					[1, "low"],
					[0, "muted"],
			  ].find(([threshold]) => threshold <= vol)?.[1];

		self.icon = `audio-volume-${icon}-symbolic`;
		self.tooltip_text = `Volumen: ${Math.floor(vol)}%`;
	}),
});

const VolumeMenu = Widget.Window({
	name: "volumeMenu",
	visible: false,
	anchor: ["top", "right"],
	css: "background-color: transparent;",
	margins: [10, 20],
	child: Widget.Slider({
		class_name: "volume_slider",
		draw_value: false,
		onChange: ({ value }) => {
			audio.speaker.volume = value;
		},
		value: audio.speaker.bind("volume"),
	}),
});

const Battery = Widget.Icon({
	icon: battery
		.bind("percent")
		.as((p) => `battery-level-${Math.floor(p / 10) * 10}-symbolic`),
	tooltip_text: battery.bind("percent").as((p) => `Batería: ${p}%`),
});

const WifiIndicator = Widget.Icon({
	icon: network.wifi.bind("icon_name"),
	tooltip_text: network.wifi.bind("ssid"),
});

const Clock = Widget.Label({
	class_name: "clock",
	label: date.bind(),
});

const SysTrayItem = (item) =>
	Widget.Button({
		child: Widget.Icon().bind("icon", item, "icon"),
		tooltipMarkup: item.bind("tooltip_markup"),
		onPrimaryClick: (_, event) => item.activate(event),
		onSecondaryClick: (_, event) => item.openMenu(event),
	});

const SysTray = Widget.Box({
	children: systemtray.bind("items").as((i) => i.map(SysTrayItem)),
});

const Left = Widget.Box({
	hpack: "start",
	spacing: 14,
	children: [Workspaces(), WindowName],
});

// const Center = Widget.Box({
//     children: []
// })

const Right = Widget.Box({
	hpack: "end",
	spacing: 14,
	children: [
		SysTray,
		Brightness,
		VolumeIndicator,
		Battery,
		WifiIndicator,
		Clock,
	],
});

const Bar = Widget.Window({
	name: "bar",
	class_name: "bar",
	anchor: ["top", "left", "right"],
	exclusivity: "exclusive",
	child: Widget.CenterBox({
		start_widget: Left,
		// center_widget: Center,
		end_widget: Right,
	}),
});

export default {
	style: "./style.css",
	windows: [Bar, VolumeMenu],
};
