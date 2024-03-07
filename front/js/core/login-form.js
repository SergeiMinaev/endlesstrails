import { r, run } from '../fr9/fr9.js';
import { httpPost } from '../common/http.js';
import { auth } from '../common/auth.js';
import { useFormValidation } from '../common/validation.js';
import { schema } from '../admin/schema.js';
import { api } from '../admin/api.js';


export class LoginForm {
  constructor() {
    window.auth = auth;
    this.auth = auth;
  }
  tpl = 't-login-form';
  state = r({
    isFormValid: r(false),
    emailErr: r(''),
    form: r({}),
  })
  onMounted() {
    const form = this.getForm();
    form.addEventListener("submit", () => {
      event.preventDefault();
      this.login(form);
    });
  }
  async login(form) {
    const btn = form.getElementsByTagName('button')[0];
    btn.disabled = true;
    const data = this.getFormData();
    btn.disabled = false;
    const resp = await httpPost('auth/login', data);
    if (resp.ok) {
      this.auth.state.user = resp.data;
      schema.loadAdminSchema();
    };
  }
  onInput(ev) {
    this.validateForm();
  }
  getForm = () => this.rootNode.getElementsByClassName('login-form')[0];
  getFormData() {
    const form = this.getForm();
    const data = new FormData(form);
    return Object.fromEntries(data);
  }
  validateForm() {
    const options = {
      formId: 'loginform',
      errMsgCls: 'err-msg',
      invalidCls: 'invalid',
      rules: {
        email: {
          required: true,
          length: [3,32],
          email: {},
        },
        pwd: {
          required: true,
          length: [8,64],
        },
      },
    };
    const { validateForm, validationMsgs } = useFormValidation();
    this.state.isFormValid.val = validateForm(options);
  }
}

