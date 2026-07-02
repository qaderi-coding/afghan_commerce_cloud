// material-ui
import Card from '@mui/material/Card'
import CardContent from '@mui/material/CardContent'
import Typography from '@mui/material/Typography'
import Box from '@mui/material/Box'
import Button from '@mui/material/Button'
import Grid from '@mui/material/Grid'

// project imports
import MainCard from 'components/MainCard'

// ==============================|| DASHBOARD - DEFAULT ||============================== //

export default function DashboardDefault() {
  return (
    <Grid container spacing={3}>
      <Grid size={12}>
        <Typography variant="h3" component="h1" gutterBottom>
          Afghan Commerce Cloud
        </Typography>
        <Typography variant="subtitle1" color="text.secondary" gutterBottom>
          ERP System - Ready for Development
        </Typography>
      </Grid>

      <Grid size={{ xs: 12, md: 6 }}>
        <MainCard title="System Status">
          <CardContent>
            <Typography variant="body1" gutterBottom>
              ✓ Frontend Foundation Ready
            </Typography>
            <Typography variant="body1" gutterBottom>
              ✓ Routing Configured
            </Typography>
            <Typography variant="body1" gutterBottom>
              ✓ Authentication Ready
            </Typography>
            <Typography variant="body1" gutterBottom>
              ✓ Theme System Active
            </Typography>
          </CardContent>
        </MainCard>
      </Grid>

      <Grid size={{ xs: 12, md: 6 }}>
        <MainCard title="Quick Actions">
          <CardContent>
            <Box sx={{ display: 'flex', gap: 2, flexWrap: 'wrap' }}>
              <Button variant="contained" color="primary">
                New Sale
              </Button>
              <Button variant="outlined">
                Add Product
              </Button>
              <Button variant="outlined">
                View Reports
              </Button>
            </Box>
          </CardContent>
        </MainCard>
      </Grid>
    </Grid>
  )
}
