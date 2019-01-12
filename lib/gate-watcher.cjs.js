'use strict';

function _typeof(obj) {
  if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") {
    _typeof = function (obj) {
      return typeof obj;
    };
  } else {
    _typeof = function (obj) {
      return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj;
    };
  }

  return _typeof(obj);
}

/**
 * GateWatcher
 *  .input(target)
 *  .option('attribute', type, defaultValue)
 *  .option('attribute', type, defaultValue)
 *  .action(target => {} : condition, target => {} : target)
 *  .parse()
 *
 * return Boolean
 */
function GateWatcher() {}

GateWatcher.prototype.initialState = function () {
  this.target = null;
  this.result = false;
  this._accept = false;
};

GateWatcher.prototype.resetState = function () {
  this.initialState();
};

GateWatcher.prototype.input = function (target) {
  if (this._accept) {
    this.resetState();
    warning(false, "don't repeat input value, GateWatcher only accept once value");
  }

  if (!notObj(target)) {
    this.resetState();
    warning(false, "GateWatcher only accept object as input");
  }

  this.target = target;
  this._accept = true;
  return this;
};

GateWatcher.prototype.option = function (attribute, type, defaultValue) {
  if (!attribute) {
    this.resetState();
    warning(false, "option requires at least one param");
  }

  var attrExist = existAttr(this.target, attribute);

  if (defaultValue && !attrExist) {
    this.target[attribute] = defaultValue;
    this.result = true;
    return this;
  }

  if (!attrExist) {
    this.result = false;
  } else if (type && this.target[attribute].constructor !== type) {
    this.result = false;
  } else {
    this.result = true;
  }

  return this;
};

GateWatcher.prototype.action = function (validitor, callback) {
  var condition = validitor(this.target);

  if (condition) {
    this.target = callback(this.target);
  }

  return this;
};

GateWatcher.prototype.parse = function () {
  var result = this.result;
  this.resetState();
  return result;
};

function notObj(obj) {
  if (!obj || obj.constructor !== Object || obj === null || !(obj instanceof Object) || _typeof(obj) !== "object" || toString(obj) !== "Object") {
    return false;
  }

  return true;
}

function existAttr(obj, key) {
  if (!obj[key] && obj[key] !== 0 || obj[key].toString().replace(/(^\s*)|(\s*$)/g, "") === "") {
    return false;
  }

  return true;
}

function warning(condition, format) {
  if (condition) {
    return;
  }

  warning(typeof format === "string", "Assert function only accepts prompt statements of string type");
  throw new Error(format);
}

function toString(obj) {
  return Object.prototype.toString.call(obj).slice(8, -1);
}

module.exports = new GateWatcher();
