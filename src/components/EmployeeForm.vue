<!-- src/components/EmployeeForm.vue -->
<script setup>
import { ref, reactive, watch, computed } from 'vue'

const props = defineProps({ editingEmployee: { type: Object, default: null } })
const emit  = defineEmits(['save', 'cancel'])

const departments = ['IT', 'HR', 'Finance', 'Marketing', 'Operations']

const emptyForm = () => ({
  empId: '', name: '', email: '', department: '',
  position: '', hireDate: '', salary: '', active: true
})

const form   = ref(emptyForm())
const errors = reactive({})

// Fill form when editing, clear when adding
watch(() => props.editingEmployee, (val) => {
  form.value = val ? { ...val } : emptyForm()
  Object.keys(errors).forEach(k => delete errors[k])
}, { immediate: true })

const isEditing = computed(() => Boolean(props.editingEmployee))

// Validation rules
function validate() {
  const today = new Date().toISOString().split('T')[0]
  const e = {}

  if (!/^EMP[0-9]{3,5}$/.test(form.value.empId.trim()))
    e.empId = 'Must be EMP followed by 3–5 digits (e.g. EMP001)'

  if (form.value.name.trim().length < 3)
    e.name = 'Name must be at least 3 characters'

  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(form.value.email.trim()))
    e.email = 'Please enter a valid email address'

  if (!form.value.department)
    e.department = 'Please select a department'

  if (!form.value.position.trim())
    e.position = 'Position is required'

  if (!form.value.hireDate || form.value.hireDate > today)
    e.hireDate = 'Hire date is required and cannot be in the future'

  const sal = Number(form.value.salary)
  if (isNaN(sal) || sal < 1500 || sal > 50000)
    e.salary = 'Salary must be between RM 1,500 and RM 50,000'

  Object.assign(errors, e)
  Object.keys(errors).forEach(k => { if (!e[k]) delete errors[k] })
  return Object.keys(e).length === 0
}

function onSubmit() {
  if (!validate()) return
  emit('save', {
    ...form.value,
    empId:    form.value.empId.trim().toUpperCase(),
    name:     form.value.name.trim(),
    email:    form.value.email.trim(),
    position: form.value.position.trim(),
    salary:   Number(form.value.salary)
  })
  if (!isEditing.value) form.value = emptyForm()
}

function onCancel() {
  emit('cancel')
  form.value = emptyForm()
}
</script>

<template>
  <form @submit.prevent="onSubmit" class="emp-form">
    <h3>{{ isEditing ? 'Edit Employee' : 'Add New Employee' }}</h3>

    <div class="form-grid">
      <label>
        Employee ID
        <input v-model.trim="form.empId" placeholder="EMP001"
               :disabled="isEditing" />
        <span class="err" v-if="errors.empId">{{ errors.empId }}</span>
      </label>

      <label>
        Full Name
        <input v-model.trim="form.name" placeholder="Full name" />
        <span class="err" v-if="errors.name">{{ errors.name }}</span>
      </label>

      <label>
        Email
        <input v-model.trim="form.email" type="email"
               placeholder="name@company.my" />
        <span class="err" v-if="errors.email">{{ errors.email }}</span>
      </label>

      <label>
        Department
        <select v-model="form.department">
          <option value="">-- Select department --</option>
          <option v-for="d in departments" :key="d" :value="d">{{ d }}</option>
        </select>
        <span class="err" v-if="errors.department">{{ errors.department }}</span>
      </label>

      <label>
        Position
        <input v-model.trim="form.position" placeholder="Job title" />
        <span class="err" v-if="errors.position">{{ errors.position }}</span>
      </label>

      <label>
        Hire Date
        <input v-model="form.hireDate" type="date" />
        <span class="err" v-if="errors.hireDate">{{ errors.hireDate }}</span>
      </label>

      <label>
        Salary (RM)
        <input v-model.number="form.salary" type="number"
               min="1500" max="50000" step="100" />
        <span class="err" v-if="errors.salary">{{ errors.salary }}</span>
      </label>

      <label class="checkbox-label">
        <input type="checkbox" v-model="form.active" />
        Active employee
      </label>
    </div>

    <div class="form-actions">
      <button type="submit">{{ isEditing ? 'Update' : 'Add Employee' }}</button>
      <button v-if="isEditing" type="button" @click="onCancel">Cancel</button>
    </div>
  </form>
</template>
