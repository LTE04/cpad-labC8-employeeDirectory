<!-- src/App.vue -->
<script setup>
import { ref, onMounted } from 'vue'
import EmployeeForm from './components/EmployeeForm.vue'
import EmployeeList from './components/EmployeeList.vue'
import {
  getEmployees, createEmployee,
  updateEmployee, deleteEmployee
} from './api/employeeApi.js'

const employees       = ref([])
const editingEmployee = ref(null)
const loading         = ref(false)
const errorMsg        = ref('')
const searchQuery     = ref('')
const sortBy          = ref('name')
const sortOrder       = ref('asc')

async function load() {
  loading.value = true
  errorMsg.value = ''
  try {
    const params = {}
    if (searchQuery.value) params.q = searchQuery.value
    if (sortBy.value)      params.sortBy = sortBy.value
    if (sortOrder.value)   params.order  = sortOrder.value
    const { data } = await getEmployees(params)
    employees.value = data
  } catch (e) {
    errorMsg.value = e.message
  } finally {
    loading.value = false
  }
}

async function handleSave(payload) {
  errorMsg.value = ''
  try {
    if (editingEmployee.value)
      await updateEmployee(editingEmployee.value.id, payload)
    else
      await createEmployee(payload)
    editingEmployee.value = null
    await load()
  } catch (e) {
    errorMsg.value = e.message
  }
}

function handleEdit(emp) { editingEmployee.value = { ...emp } }
function handleCancel()  { editingEmployee.value = null }

async function handleDelete(id) {
  if (!confirm('Delete this employee? This cannot be undone.')) return
  try {
    await deleteEmployee(id)
    await load()
  } catch (e) {
    errorMsg.value = e.message
  }
}

const activeCount = () => employees.value.filter(e => e.active).length

onMounted(load)
</script>

<template>
  <header>
    <h1>Employee Directory</h1>
    <p class="subtitle">Vue 3 · Axios · Express · MySQL</p>
    <p class="headcount">Active employees: {{ activeCount() }}</p>
  </header>

  <main>
    <p v-if="errorMsg" class="error-banner">{{ errorMsg }}</p>

    <div class="controls">
      <input v-model="searchQuery" @input="load"
             placeholder="Search by name, ID or email..." />
      <select v-model="sortBy" @change="load">
        <option value="name">Sort by Name</option>
        <option value="hireDate">Sort by Hire Date</option>
        <option value="salary">Sort by Salary</option>
      </select>
      <select v-model="sortOrder" @change="load">
        <option value="asc">Ascending</option>
        <option value="desc">Descending</option>
      </select>
    </div>

    <EmployeeForm
      :editingEmployee="editingEmployee"
      @save="handleSave"
      @cancel="handleCancel" />

    <EmployeeList
      :employees="employees"
      :loading="loading"
      @edit="handleEdit"
      @delete="handleDelete" />
  </main>
</template>
