import axios from 'axios';

class HostawayAuthService {
  private accessToken: string | null = null;
  private expiryTime: number | null = null;

  async getValidToken(): Promise<string> {
    // Check if token exists and is still valid (with a 30-second buffer)
    if (this.accessToken && this.expiryTime && Date.now() < this.expiryTime - 30000) {
      return this.accessToken;
    }

    return this.refreshAccessToken();
  }

  private async refreshAccessToken(): Promise<string> {
    try {
      const response = await axios.post('https://api.hostaway.com/v1/accessTokens', {
        grant_type: 'client_credentials',
        client_id: process.env.HOSTAWAY_ACCOUNT_ID,
        client_secret: process.env.HOSTAWAY_API_KEY,
        scope: 'general' 
      }, {
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
      });

      this.accessToken = response.data.access_token;
      // expires_in is in seconds; convert to absolute timestamp in ms
      this.expiryTime = Date.now() + (response.data.expires_in * 1000);

      return this.accessToken!;
    } catch (error) {
      console.error('Failed to refresh Hostaway token', error);
      throw new Error('Authentication failed');
    }
  }
}

export const hostawayAuthService = new HostawayAuthService();