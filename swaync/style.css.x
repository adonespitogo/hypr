@define-color cc-bg rgba(0, 0, 0, 1);
@define-color noti-border-color rgba(255, 255, 255, 0.15);
@define-color noti-bg rgb(17, 17, 27);
@define-color noti-bg-darker rgb(43, 43, 57);
@define-color noti-bg-hover rgb(27, 27, 43);
@define-color noti-bg-focus rgba(27, 27, 27, 0.6);
@define-color noti-close-bg rgba(255, 255, 255, 0.1);
@define-color noti-close-bg-hover rgba(255, 255, 255, 0.15);
@define-color text-color rgba(169, 177, 214, 1);
@define-color text-color-disabled rgb(150, 150, 150);
@define-color bg-selected rgb(0, 128, 255);

* {
  font-family: JetBrainsMono Nerd Font Propo;
  font-weight: bolder;
}

.control-center .notification-row:focus,
.control-center .notification-row:hover {
  opacity: 1;
  background: @noti-bg-darker;
}

.notification-row {
  outline: none;
}

.notification {
  border-radius: 12px;
  margin: 10px;
  padding: 0;
  border: 2px solid #7aa2f7;
}

.notification-content {
  background: transparent;
  padding: 10px;
  border-radius: 12px;
}

.close-button {
  background: @noti-close-bg;
  color: @text-color;
  text-shadow: none;
  padding: 0;
  border-radius: 100%;
  box-shadow: none;
  border: none;
  min-width: 24px;
  min-height: 24px;
  margin-top: 10px;
  margin-right: 16px;
}

.close-button:hover {
  box-shadow: none;
  background: @noti-close-bg-hover;
  transition: all 0.15s ease-in-out;
  border: none;
}

.notification-default-action,
.notification-action {
  padding: 4px;
  margin: 0;
  box-shadow: none;
  background: @noti-bg;
  border: none;
  color: @text-color;
  transition: all 0.15s ease-in-out;
}

.notification-default-action:hover,
.notification-action:hover {
  -gtk-icon-effect: none;
  background: @noti-bg-hover;
}

.notification-default-action {
  border-radius: 12px;
}

.notification-default-action:not(:only-child) {
  border-bottom-left-radius: 0;
  border-bottom-right-radius: 0;
}

.notification-action {
  border-radius: 0;
  border-top: none;
  border-right: none;
}

.notification-action:first-child {
  border-bottom-left-radius: 10px;
  background: #1b1b2b;
}

.notification-action:last-child {
  border-bottom-right-radius: 10px;
  background: #1b1b2b;
}

.inline-reply {
  margin-top: 8px;
}

.inline-reply-entry {
  background: @noti-bg-darker;
  color: @text-color;
  caret-color: @text-color;
  border: 1px solid @noti-border-color;
  border-radius: 12px;
}

.inline-reply-button {
  margin-left: 4px;
  background: @noti-bg;
  border: 1px solid @noti-border-color;
  border-radius: 12px;
  color: @text-color;
}

.inline-reply-button:disabled {
  background: initial;
  color: @text-color-disabled;
  border: 1px solid transparent;
}

.inline-reply-button:hover {
  background: @noti-bg-hover;
}

.body-image {
  margin-top: 6px;
  background-color: #fff;
  border-radius: 12px;
}

.summary {
  font-size: 16px;
  font-weight: 700;
  background: transparent;
  color: rgba(158, 206, 106, 1);
  text-shadow: none;
}

.time {
  font-size: 16px;
  font-weight: 700;
  background: transparent;
  color: @text-color;
  text-shadow: none;
  margin-right: 18px;
}

.body {
  font-size: 15px;
  font-weight: 400;
  background: transparent;
  color: @text-color;
  text-shadow: none;
}

.control-center {
  background: @cc-bg;
  border: 1px solid #7aa2f7;
  border-radius: 10px;
}

.control-center-list {
  background: transparent;
}

.control-center-list-placeholder {
  opacity: 0.5;
}

.floating-notifications {
  background: transparent;
}

.blank-window {
  background: alpha(black, 0.25);
}

.widget-title {
  color: @text-color;
  margin: 10px;
  font-size: 1.5rem;
}

.widget-title > button {
  font-size: initial;
  color: @text-color;
  text-shadow: none;
  background: @noti-bg;
  border: 1px solid @noti-border-color;
  box-shadow: none;
  border-radius: 12px;
}

.widget-title > button:hover {
  background: @noti-bg-hover;
}

.widget-dnd {
  color: @text-color;
  margin: 10px;
  font-size: 1.1rem;
}

.widget-dnd > switch {
  font-size: initial;
  border-radius: 12px;
  background: @noti-bg;
  border: 1px solid @noti-border-color;
  box-shadow: none;
}

.widget-dnd > switch:checked {
  background: @bg-selected;
}

.widget-dnd > switch slider {
  background: @noti-bg-hover;
  border-radius: 12px;
}

.widget-label {
  margin: 10px;
}

.widget-label > label {
  font-size: 1.5rem;
  color: @text-color;
}

.widget-mpris {
  color: @text-color;
  background: @noti-bg-darker;
  padding: 10px;
  margin: 10px;
  border-radius: 10px;
}

.widget-mpris-player {
  padding: 8px;
  margin: 8px;
}

.widget-mpris-title {
  font-weight: 700;
  font-size: 1.25rem;
}

.widget-mpris-subtitle {
  font-size: 1.1rem;
}

.widget-buttons-grid {
  font-size: x-large;
  padding: 8px;
  margin: 20px 10px 10px;
  border-radius: 12px;
  background: @noti-bg-darker;
}

.widget-buttons-grid > flowbox > flowboxchild > button {
  margin: 3px;
  background: #343b58;
  border-radius: 12px;
  color: @text-color;
}

.widget-buttons-grid > flowbox > flowboxchild > button:hover {
  /* background: @noti-bg-hover; */
  color: rgba(158, 206, 106, 1);
}

.widget-menubar > box > .menu-button-bar > button {
  border: none;
  background: transparent;
}

.topbar-buttons > button {
  border: none;
  background: transparent;
}

.widget-volume {
  background: @noti-bg-darker;
  padding: 8px;
  margin: 10px;
  border-radius: 12px;
  font-size: x-large;
  color: @text-color;
}

.widget-volume > box > button {
  background: transparent;
  border: none;
}

.per-app-volume {
  background-color: @noti-bg;
  padding: 4px 8px 8px;
  margin: 0 8px 8px;
  border-radius: 12px;
}

.widget-backlight {
  background: @noti-bg-darker;
  padding: 8px;
  margin: 10px;
  border-radius: 12px;
  font-size: x-large;
  color: @text-color;
}

.widget-inhibitors {
  margin: 8px;
  font-size: 1.5rem;
}

.widget-inhibitors > button {
  font-size: initial;
  color: @text-color;
  text-shadow: none;
  background: @noti-bg;
  border: 1px solid @noti-border-color;
  box-shadow: none;
  border-radius: 12px;
}

.widget-inhibitors > button:hover {
  background: @noti-bg-hover;
}
