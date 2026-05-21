<!-- src/components/EmployeeList.vue -->
<script setup>
defineProps({
  employees: { type: Array, required: true },
  loading:   { type: Boolean, default: false }
})
const emit = defineEmits(['edit', 'delete'])

// Format salary as Malaysian Ringgit
const formatSalary = (val) =>
  new Intl.NumberFormat('ms-MY', {
    style: 'currency',
    currency: 'MYR'
  }).format(val)

// Format date nicely
const formatDate = (d) =>
  new Date(d).toLocaleDateString('en-MY', {
    year: 'numeric', month: 'short', day: 'numeric'
  })
</script>

<template>
  <div class="list-section">

    <div v-if="loading" class="loading">
      Loading employees...
    </div>

    <div v-else-if="!employees.length" class="empty">
      No employees found.
    </div>

    <div v-else class="table-wrap">
      <table class="emp-table">
        <thead>
          <tr>
            <th>Emp ID</th>
            <th>Name</th>
            <th>Department</th>
            <th>Position</th>
            <th>Hire Date</th>
            <th>Salary</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="emp in employees" :key="emp.id">
            <td><code>{{ emp.empId }}</code></td>
            <td>
              <strong>{{ emp.name }}</strong>
              <div class="muted">{{ emp.email }}</div>
            </td>
            <td>{{ emp.department }}</td>
            <td>{{ emp.position }}</td>
            <td>{{ formatDate(emp.hireDate) }}</td>
            <td>{{ formatSalary(emp.salary) }}</td>
            <td>
              <span :class="emp.active ? 'badge active' : 'badge inactive'">
                {{ emp.active ? 'Active' : 'Inactive' }}
              </span>
            </td>
            <td class="actions">
              <button @click="emit('edit', emp)">Edit</button>
              <button class="danger"
                      @click="emit('delete', emp.id)">Delete</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

  </div>
</template>