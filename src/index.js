/**
 * GateWatcher
 *  .input(target)
 *  .option('attribute', type, defaultValue)
 *  .exist([attr, attr, ...])
 *  .parse()
 * return Boolean
 */

function GateWatcher() {}

GateWatcher.prototype.initialState = function() {
  this.target = null;
  this.result = false;
  this._accept = false;
};

GateWatcher.prototype.resetState = function() {
  this.initialState();
};

GateWatcher.prototype.input = function(target) {
  if (this._accept) {
    this.resetState();
    warning(
      false,
      "don't repeat input value, GateWatcher only accept once value"
    );
  }

  if (!notObj(target)) {
    this.resetState();
    warning(false, "GateWatcher only accept object as input");
  }

  this.target = target;
  this._accept = true;
  return this;
};

GateWatcher.prototype.option = function(attribute, type, defaultValue) {
  if (!attribute) {
    this.resetState();
    warning(false, "option requires at least one param");
  }

  const attrExist = existAttr(this.target, attribute);

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

GateWatcher.prototype.exist = function(attrs) {
  if (!attrs || attrs.constructor.name !== "Array") {
    this.resetState();
    warning(
      false,
      "exist requires at least one param and type of attributes must is array."
    );
  }

  for (let i = 0, l = attrs.length; i < l; i++) {
    if (existAttr(this.target, attrs[i])) {
      this.result = true;
      return this;
    }
  }

  this.result = false;
  return this;
};

GateWatcher.prototype.action = function(validitor, callback) {
  const condition = validitor(this.target);

  if (condition) {
    callback(this.target);
  }

  return this;
};

GateWatcher.prototype.parse = function() {
  const result = this.result;
  this.resetState();

  return result;
};

function notObj(obj) {
  if (
    !obj ||
    obj.constructor !== Object ||
    obj === null ||
    !(obj instanceof Object) ||
    typeof obj !== "object" ||
    toString(obj) !== "Object"
  ) {
    return false;
  }
  return true;
}

function existAttr(obj, key) {
  if (
    (!obj[key] && obj[key] !== 0) ||
    obj[key].toString().replace(/(^\s*)|(\s*$)/g, "") === ""
  ) {
    return false;
  }

  return true;
}

function warning(condition, format) {
  if (condition) {
    return;
  }

  warning(
    typeof format === "string",
    "Assert function only accepts prompt statements of string type"
  );

  throw new Error(format);
}

function toString(obj) {
  return Object.prototype.toString.call(obj).slice(8, -1);
}

module.exports = new GateWatcher();
